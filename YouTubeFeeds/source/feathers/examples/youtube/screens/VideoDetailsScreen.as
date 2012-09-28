package feathers.examples.youtube.screens
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Screen;
	import feathers.controls.ScrollText;
	import feathers.examples.youtube.models.YouTubeModel;

	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;

	public class VideoDetailsScreen extends Screen
	{
		public function VideoDetailsScreen()
		{
		}

		private var _header:Header;
		private var _backButton:Button;
		private var _watchButton:Button;
		private var _scrollText:ScrollText;

		private var _model:YouTubeModel;

		public function get model():YouTubeModel
		{
			return this._model;
		}

		public function set model(value:YouTubeModel):void
		{
			if(this._model == value)
			{
				return;
			}
			this._model = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		private var _onComplete:Signal = new Signal(VideoDetailsScreen);

		public function get onComplete():ISignal
		{
			return this._onComplete;
		}

		override protected function initialize():void
		{
			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(onBackButton);

			this._watchButton = new Button();
			this._watchButton.label = "Watch";
			this._watchButton.onRelease.add(watchButton_onRelease);

			this._header = new Header();
			this.addChild(this._header);
			this._header.leftItems = new <DisplayObject>
			[
				this._backButton
			];
			this._header.rightItems = new <DisplayObject>
			[
				this._watchButton
			];

			this._scrollText = new ScrollText();
			this._scrollText.isHTML = true;
			this.addChild(this._scrollText);

			this.backButtonHandler = onBackButton;
		}

		override protected function draw():void
		{
			const dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);

			if(dataInvalid)
			{
				if(this._model && this._model.selectedVideo)
				{
					this._header.title = this._model.selectedVideo.title;
					var content:String = '<p><b><font size="+2">' + this._model.selectedVideo.title + '</font></b></p>';
					content += '<p><font size="-2" color="#999999">' + this._model.selectedVideo.author + '</font></p><br>';
					content += this._model.selectedVideo.description.replace(/\r\n/g, "<br>");
					this._scrollText.text = content;
				}
				else
				{
					this._header.title = null;
					this._scrollText.text = "";
				}
			}

			this._header.width = this.actualWidth;
			this._header.validate();

			this._scrollText.width = this.actualWidth;
			this._scrollText.y = this._header.height;
			this._scrollText.height = this.actualHeight - this._scrollText.y;
		}

		private function onBackButton(button:Button = null):void
		{
			this._onComplete.dispatch(this);
		}

		private function watchButton_onRelease(button:Button):void
		{
			navigateToURL(new URLRequest(this._model.selectedVideo.url), "_blank");
		}
	}
}
