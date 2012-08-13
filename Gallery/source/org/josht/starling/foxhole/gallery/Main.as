package org.josht.starling.foxhole.gallery
{
	import com.gskinner.motion.easing.Sine;

	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextFormat;

	import org.josht.starling.foxhole.controls.List;
	import org.josht.starling.foxhole.controls.Scroller;
	import org.josht.starling.foxhole.controls.text.TextFieldTextRenderer;
	import org.josht.starling.foxhole.core.FoxholeControl;
	import org.josht.starling.foxhole.data.ListCollection;
	import org.josht.starling.foxhole.layout.HorizontalLayout;
	import org.josht.starling.motion.GTween;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.textures.Texture;

	public class Main extends Sprite
	{
		private static const FLICKR_URL:String = "http://api.flickr.com/services/rest/?method=flickr.interestingness.getList&api_key=" + CONFIG::FLICKR_API_KEY + "&format=rest";
		private static const FLICKR_PHOTO_URL:String = "http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_{size}.jpg";

		public function Main()
		{
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		protected var selectedImage:Image;
		protected var list:List;
		protected var message:TextFieldTextRenderer;
		protected var apiLoader:URLLoader;
		protected var loader:Loader;
		protected var fadeTween:GTween;
		protected var originalImageWidth:Number;
		protected var originalImageHeight:Number;

		protected function layout():void
		{
			this.list.width = this.stage.stageWidth;
			this.list.height = 100;
			this.list.y = this.stage.stageHeight - this.list.height;

			if(this.selectedImage)
			{
				var availableHeight:Number = this.stage.stageHeight - this.list.height;
				var widthScale:Number = this.stage.stageWidth / this.originalImageWidth;
				var heightScale:Number = availableHeight / this.originalImageHeight;
				this.selectedImage.scaleX = this.selectedImage.scaleY = Math.min(1, widthScale, heightScale);
				this.selectedImage.x = (this.stage.stageWidth - this.selectedImage.width) / 2;
				this.selectedImage.y = (availableHeight - this.selectedImage.height) / 2;
			}

			this.message.validate();
			availableHeight = this.stage.stageHeight - this.list.height;
			this.message.x = (this.stage.stageWidth - this.message.width) / 2;
			this.message.y = (availableHeight - this.message.height) / 2;
		}

		protected function list_onChange(list:List):void
		{
			const item:GalleryItem = GalleryItem(list.selectedItem);
			if(!item)
			{
				if(this.selectedImage)
				{
					this.selectedImage.visible = false;
				}
				return;
			}
			if(this.loader)
			{
				this.loader.unloadAndStop(true);
			}
			else
			{
				this.loader = new Loader();
				this.loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, loader_completeHandler);
			}
			this.loader.load(new URLRequest(item.url));
			if(this.selectedImage)
			{
				this.selectedImage.visible = false;
			}
			if(this.fadeTween)
			{
				this.fadeTween.paused = true;
				this.fadeTween = null;
			}
			this.message.text = "Loading...";
			this.layout();
		}

		protected function addedToStageHandler(event:starling.events.Event):void
		{
			this.apiLoader = new URLLoader();
			this.apiLoader.addEventListener(flash.events.Event.COMPLETE, apiLoader_completeListener);
			this.apiLoader.load(new URLRequest(FLICKR_URL));

			this.stage.addEventListener(ResizeEvent.RESIZE, stage_resizeHandler);

			FoxholeControl.defaultTextRendererFactory = function():TextFieldTextRenderer
			{
				return new TextFieldTextRenderer();
			};

			this.list = new List();
			this.list.layout = new HorizontalLayout();
			this.list.backgroundSkin = new Quad(100, 100, 0x222222);
			this.list.scrollerProperties.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			this.list.itemRendererType = GalleryItemRenderer;
			this.list.itemRendererProperties.labelField = "title";
			this.list.itemRendererProperties.width = 100;
			this.list.itemRendererProperties.height = 100;
			this.list.onChange.add(list_onChange);
			this.addChild(this.list);

			this.message = new TextFieldTextRenderer();
			this.message.textFormat = new TextFormat("Helvetica,Arial,_sans", 14, 0xffffff, true);
			this.message.text = "Loading...";
			this.addChild(this.message);

			this.layout();
		}

		protected function stage_resizeHandler(event:ResizeEvent):void
		{
			this.layout();
		}

		protected function apiLoader_completeListener(event:flash.events.Event):void
		{
			const result:XML = XML(this.apiLoader.data);
			if(result.attribute("stat") == "fail")
			{
				message.text = "Unable to load the list of images from Flickr at this time.";
				this.layout();
				return;
			}
			const items:Vector.<GalleryItem> = new <GalleryItem>[];
			const photosList:XMLList = result.photos.photo;
			const photoCount:int = photosList.length();
			for(var i:int = 0; i < photoCount; i++)
			{
				var photoXML:XML = photosList[i];
				var url:String = FLICKR_PHOTO_URL.replace("{farm-id}", photoXML.@farm.toString());
				url = url.replace("{server-id}", photoXML.@server.toString());
				url = url.replace("{id}", photoXML.@id.toString());
				url = url.replace("{secret}", photoXML.@secret.toString());
				var thumbURL:String = url.replace("{size}", "t");
				url = url.replace("{size}", "b");
				var title:String = photoXML.@title.toString();
				items.push(new GalleryItem(title, url, thumbURL));
			}

			this.message.text = "";

			this.list.dataProvider = new ListCollection(items);
			this.list.selectedIndex = 0;
		}

		protected function loader_completeHandler(event:flash.events.Event):void
		{
			const texture:Texture = Texture.fromBitmap(Bitmap(this.loader.content));
			if(this.selectedImage)
			{
				this.selectedImage.texture.dispose();
				this.selectedImage.texture = texture;
				this.selectedImage.scaleX = this.selectedImage.scaleY = 1;
				this.selectedImage.readjustSize();
			}
			else
			{
				this.selectedImage = new Image(texture);
				this.addChildAt(this.selectedImage, 1);
			}
			this.originalImageWidth = this.selectedImage.width;
			this.originalImageHeight = this.selectedImage.height;
			this.selectedImage.alpha = 0;
			this.selectedImage.visible = true;

			this.fadeTween = new GTween(this.selectedImage, 0.5,
			{
				alpha: 1
			},
			{
				ease: Sine.easeOut
			});

			this.message.text = "";

			this.layout();
		}
	}
}
