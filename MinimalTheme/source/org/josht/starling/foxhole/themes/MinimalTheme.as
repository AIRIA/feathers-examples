package org.josht.starling.foxhole.themes
{
	import flash.geom.Rectangle;
	import flash.system.Capabilities;

	import org.josht.starling.display.Image;
	import org.josht.starling.display.Scale9Image;
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.Callout;
	import org.josht.starling.foxhole.controls.Check;
	import org.josht.starling.foxhole.controls.FPSDisplay;
	import org.josht.starling.foxhole.controls.Label;
	import org.josht.starling.foxhole.controls.PickerList;
	import org.josht.starling.foxhole.controls.ProgressBar;
	import org.josht.starling.foxhole.controls.Radio;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.controls.Slider;
	import org.josht.starling.foxhole.controls.TextInput;
	import org.josht.starling.foxhole.controls.ToggleSwitch;
	import org.josht.starling.foxhole.controls.popups.CalloutPopUpContentManager;
	import org.josht.starling.foxhole.controls.popups.VerticalCenteredPopUpContentManager;
	import org.josht.starling.foxhole.controls.renderers.BaseDefaultItemRenderer;
	import org.josht.starling.foxhole.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer;
	import org.josht.starling.foxhole.controls.renderers.DefaultGroupedListItemRenderer;
	import org.josht.starling.foxhole.controls.renderers.DefaultListItemRenderer;
	import org.josht.starling.foxhole.core.AddedWatcher;
	import org.josht.starling.foxhole.layout.VerticalLayout;
	import org.josht.starling.foxhole.skins.ImageStateValueManager;
	import org.josht.starling.foxhole.skins.Scale9ImageStateValueManager;
	import org.josht.starling.foxhole.skins.StateValueManager;
	import org.josht.starling.foxhole.text.BitmapFontTextFormat;
	import org.josht.starling.textures.Scale9Textures;
	import org.josht.system.PhysicalCapabilities;
	import org.josht.utils.math.roundToNearest;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;

	public class MinimalTheme extends AddedWatcher implements IFoxholeTheme
	{
		[Embed(source="/../assets/images/minimal.png")]
		protected static const ATLAS_IMAGE:Class;

		[Embed(source="/../assets/images/minimal.xml",mimeType="application/octet-stream")]
		protected static const ATLAS_XML:Class;

		protected static const ATLAS:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new ATLAS_IMAGE(), false), XML(new ATLAS_XML()));

		protected static const SCALE_9_GRID:Rectangle = new Rectangle(9, 9, 2, 2);
		protected static const SCROLLBAR_THUMB_SCALE_9_GRID:Rectangle = new Rectangle(1, 1, 2, 2);
		protected static const TAB_SCALE_9_GRID:Rectangle = new Rectangle(25, 25, 2, 2);
		protected static const CHECK_SCALE_9_GRID:Rectangle = new Rectangle(13, 13, 2, 2);

		protected static const BACKGROUND_COLOR:uint = 0xf3f3f3;
		protected static const PRIMARY_TEXT_COLOR:uint = 0x666666;
		protected static const SELECTED_TEXT_COLOR:uint = 0x333333;
		protected static const INSET_TEXT_COLOR:uint = 0x333333;

		protected static const ORIGINAL_DPI_IPHONE_RETINA:int = 326;
		protected static const ORIGINAL_DPI_IPAD_RETINA:int = 264;

		protected static const TOOLBAR_BUTTON_UP_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("toolbar-button-up-skin"), SCALE_9_GRID);
		protected static const TOOLBAR_BUTTON_DOWN_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("toolbar-button-down-skin"), SCALE_9_GRID);
		protected static const TOOLBAR_BUTTON_SELECTED_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("toolbar-button-selected-skin"), SCALE_9_GRID);

		protected static const BUTTON_UP_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("button-up-skin"), SCALE_9_GRID);
		protected static const BUTTON_DOWN_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("button-down-skin"), SCALE_9_GRID);
		protected static const BUTTON_DISABLED_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("button-disabled-skin"), SCALE_9_GRID);
		protected static const BUTTON_SELECTED_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("button-selected-skin"), SCALE_9_GRID);

		protected static const TAB_UP_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("tab-up-skin"), SCALE_9_GRID);
		protected static const TAB_DOWN_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("tab-down-skin"), TAB_SCALE_9_GRID);
		protected static const TAB_SELECTED_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("tab-selected-skin"), TAB_SCALE_9_GRID);

		protected static const THUMB_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("thumb-skin"), SCALE_9_GRID);

		protected static const SCROLL_BAR_THUMB_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("scrollbar-thumb-skin"), SCROLLBAR_THUMB_SCALE_9_GRID);

		protected static const INSET_BACKGROUND_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("inset-background-skin"), SCALE_9_GRID);
		protected static const INSET_BACKGROUND_DISABLED_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("inset-background-disabled-skin"), SCALE_9_GRID);

		protected static const DROP_DOWN_ARROW_TEXTURE:Texture = ATLAS.getTexture("drop-down-arrow");

		protected static const LIST_ITEM_UP_TEXTURE:Texture = ATLAS.getTexture("list-item-up");
		protected static const LIST_ITEM_DOWN_TEXTURE:Texture = ATLAS.getTexture("list-item-down");
		protected static const LIST_ITEM_SELECTED_TEXTURE:Texture = ATLAS.getTexture("list-item-selected");

		protected static const HEADER_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("header-skin"), SCALE_9_GRID);

		protected static const POPUP_BACKGROUND_SKIN_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("callout-background-skin"), SCALE_9_GRID);
		protected static const CALLOUT_TOP_ARROW_SKIN_TEXTURE:Texture = ATLAS.getTexture("callout-arrow-top");
		protected static const CALLOUT_BOTTOM_ARROW_SKIN_TEXTURE:Texture = ATLAS.getTexture("callout-arrow-bottom");
		protected static const CALLOUT_LEFT_ARROW_SKIN_TEXTURE:Texture = ATLAS.getTexture("callout-arrow-left");
		protected static const CALLOUT_RIGHT_ARROW_SKIN_TEXTURE:Texture = ATLAS.getTexture("callout-arrow-right");

		protected static const CHECK_SELECTED_ICON_TEXTURES:Scale9Textures = new Scale9Textures(ATLAS.getTexture("check-selected-icon"), CHECK_SCALE_9_GRID);

		protected static const RADIO_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-icon");
		protected static const RADIO_SELECTED_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-selected-icon");

		[Embed(source="/../assets/fonts/pf_ronda_seven.fnt",mimeType="application/octet-stream")]
		protected static const ATLAS_FONT_XML:Class;

		protected static const BITMAP_FONT:BitmapFont = new BitmapFont(ATLAS.getTexture("pf_ronda_seven_0"), XML(new ATLAS_FONT_XML()));

		public function MinimalTheme(root:DisplayObject, scaleToDPI:Boolean = true)
		{
			super(root);
			Starling.current.nativeStage.color = BACKGROUND_COLOR;
			if(root.stage)
			{
				root.stage.color = BACKGROUND_COLOR;
			}
			else
			{
				root.addEventListener(Event.ADDED_TO_STAGE, root_addedToStageHandler);
			}
			this._scaleToDPI = scaleToDPI;
			this.initialize();
		}

		protected var _originalDPI:int;

		public function get originalDPI():int
		{
			return this._originalDPI;
		}

		protected var _scaleToDPI:Boolean;

		public function get scaleToDPI():Boolean
		{
			return this._scaleToDPI;
		}

		protected var _scale:Number;
		protected var _fontSize:int;

		protected function initialize():void
		{
			if(this._scaleToDPI)
			{
				//special case for ipad. should be same pixel size as iphone
				if(Capabilities.screenDPI % (ORIGINAL_DPI_IPAD_RETINA / 2) == 0)
				{
					this._originalDPI = ORIGINAL_DPI_IPAD_RETINA;
				}
				else
				{
					this._originalDPI = ORIGINAL_DPI_IPHONE_RETINA;
				}
			}
			else
			{
				this._originalDPI = Capabilities.screenDPI;
			}
			this._scale = Capabilities.screenDPI / this._originalDPI;

			//since it's a pixel font, we want a multiple of the original size,
			//which, in this case, is 8.
			this._fontSize = Math.max(4, roundToNearest(24 * this._scale, 8));

			this.setInitializerForClass(Label, labelInitializer);
			this.setInitializerForClass(FPSDisplay, labelInitializer);
			this.setInitializerForClass(Button, buttonInitializer);
			this.setInitializerForClass(Slider, sliderInitializer);
			this.setInitializerForClass(ToggleSwitch, toggleSwitchInitializer);
			this.setInitializerForClass(Check, checkInitializer);
			this.setInitializerForClass(Radio, radioInitializer);
			this.setInitializerForClass(DefaultListItemRenderer, itemRendererInitializer);
			this.setInitializerForClass(DefaultGroupedListItemRenderer, itemRendererInitializer);
			this.setInitializerForClass(DefaultGroupedListHeaderOrFooterRenderer, headerOrFooterRendererInitializer);
			this.setInitializerForClass(PickerList, pickerListInitializer);
			this.setInitializerForClass(ScreenHeader, screenHeaderInitializer);
			this.setInitializerForClass(TextInput, textInputInitializer);
			this.setInitializerForClass(ProgressBar, progressBarInitializer);
			this.setInitializerForClass(Callout, calloutInitializer);
		}

		protected function labelInitializer(label:Label):void
		{
			label.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			//since it's a pixel font, we don't want to smooth it.
			label.smoothing = TextureSmoothing.NONE;
		}

		protected function buttonInitializer(button:Button):void
		{
			button.minTouchWidth = button.minTouchHeight = 88 * this._scale;
			if(button.nameList.contains("foxhole-slider-thumb"))
			{
				const sliderThumbDefaultSkin:Scale9Image = new Scale9Image(THUMB_SKIN_TEXTURES, this._scale);
				sliderThumbDefaultSkin.width = 66 * this._scale;
				sliderThumbDefaultSkin.height = 66 * this._scale;
				button.defaultSkin = sliderThumbDefaultSkin;
			}
			else if(button.nameList.contains("foxhole-slider-minimum-track") || button.nameList.contains("foxhole-slider-maximum-track"))
			{
				//no skin is defined here. we're taking care of these based on
				//the slider's direction.
			}
			else if(button.nameList.contains("foxhole-simple-scroll-bar-thumb"))
			{
				const scrollBarThumbDefaultSkin:Scale9Image = new Scale9Image(SCROLL_BAR_THUMB_SKIN_TEXTURES, this._scale);
				scrollBarThumbDefaultSkin.width = 8 * this._scale;
				scrollBarThumbDefaultSkin.height = 8 * this._scale;
				button.defaultSkin = scrollBarThumbDefaultSkin;
				button.minTouchWidth = button.minTouchHeight = 12 * this._scale;
			}
			else if(button.nameList.contains("foxhole-toggle-switch-thumb"))
			{
				const toggleSwitchThumbDefaultSkin:Scale9Image = new Scale9Image(THUMB_SKIN_TEXTURES, this._scale);
				toggleSwitchThumbDefaultSkin.width = 66 * this._scale;
				toggleSwitchThumbDefaultSkin.height = 66 * this._scale;
				button.defaultSkin = toggleSwitchThumbDefaultSkin;
			}
			else if(button.nameList.contains("foxhole-tabbar-tab"))
			{
				const tabSkinManager:Scale9ImageStateValueManager = new Scale9ImageStateValueManager();
				tabSkinManager.defaultValue = TAB_UP_SKIN_TEXTURES;
				tabSkinManager.defaultSelectedValue = TAB_SELECTED_SKIN_TEXTURES;
				tabSkinManager.setValueForState(Button.STATE_DOWN, TAB_DOWN_SKIN_TEXTURES);
				tabSkinManager.imageProperties =
				{
					width: 88 * this._scale,
					height: 88 * this._scale,
					textureScale: this._scale
				};
				button.stateToSkinFunction = tabSkinManager.updateValue;

				button.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
				button.defaultSelectedTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);

				button.iconPosition = Button.ICON_POSITION_TOP;
				button.paddingTop = button.paddingRight = button.paddingBottom =
					button.paddingLeft = 28 * this._scale;
				button.gap = 12 * this._scale;
				button.minWidth = 88 * this._scale;
				button.minHeight = 88 * this._scale;
			}
			else if(button.nameList.contains("foxhole-header-item"))
			{
				const headerButtonSkinManager:Scale9ImageStateValueManager = new Scale9ImageStateValueManager();
				headerButtonSkinManager.defaultValue = TOOLBAR_BUTTON_UP_SKIN_TEXTURES;
				headerButtonSkinManager.defaultSelectedValue = TOOLBAR_BUTTON_SELECTED_SKIN_TEXTURES;
				headerButtonSkinManager.setValueForState(Button.STATE_DOWN, TOOLBAR_BUTTON_DOWN_SKIN_TEXTURES);
				headerButtonSkinManager.setValueForState(Button.STATE_SELECTED_DOWN, TOOLBAR_BUTTON_DOWN_SKIN_TEXTURES);
				headerButtonSkinManager.imageProperties =
				{
					width: 60 * this._scale,
					height: 60 * this._scale,
					textureScale: this._scale
				};
				button.stateToSkinFunction = headerButtonSkinManager.updateValue;

				button.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
				button.defaultSelectedTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);

				button.paddingTop = button.paddingBottom = 8 * this._scale;
				button.paddingLeft = button.paddingRight = 16 * this._scale;
				button.gap = 12 * this._scale;
				button.minWidth = 60 * this._scale;
				button.minHeight = 60 * this._scale;
			}
			else
			{
				const skinManager:Scale9ImageStateValueManager = new Scale9ImageStateValueManager();
				skinManager.defaultValue = BUTTON_UP_SKIN_TEXTURES;
				skinManager.defaultSelectedValue = BUTTON_SELECTED_SKIN_TEXTURES;
				skinManager.setValueForState(Button.STATE_DOWN, BUTTON_DOWN_SKIN_TEXTURES);
				skinManager.setValueForState(Button.STATE_DISABLED, BUTTON_DISABLED_SKIN_TEXTURES);
				skinManager.setValueForState(Button.STATE_SELECTED_DOWN, BUTTON_DOWN_SKIN_TEXTURES);
				skinManager.imageProperties =
				{
					width: 66 * this._scale,
					height: 66 * this._scale,
					textureScale: this._scale
				};
				button.stateToSkinFunction = skinManager.updateValue;

				button.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
				button.defaultSelectedTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);

				button.paddingTop = button.paddingBottom = 8 * this._scale;
				button.paddingLeft = button.paddingRight = 16 * this._scale;
				button.gap = 12 * this._scale;
				button.minWidth = 66 * this._scale;
				button.minHeight = 66 * this._scale;
			}

			//we're tweaking the normal button styles
			if(button.nameList.contains("foxhole-pickerlist-button"))
			{
				const pickerListButtonDefaultIcon:Image = new Image(DROP_DOWN_ARROW_TEXTURE);
				pickerListButtonDefaultIcon.scaleX = pickerListButtonDefaultIcon.scaleY = this._scale;
				button.defaultIcon = pickerListButtonDefaultIcon;
				button.gap = Number.POSITIVE_INFINITY, //fill as completely as possible
				button.iconPosition = Button.ICON_POSITION_RIGHT;
				button.horizontalAlign =  Button.HORIZONTAL_ALIGN_LEFT;
			}
		}

		protected function sliderInitializer(slider:Slider):void
		{
			slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_SINGLE;

			const sliderTrackDefaultSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_SKIN_TEXTURES, this._scale);
			if(slider.direction == Slider.DIRECTION_VERTICAL)
			{
				sliderTrackDefaultSkin.width = 66 * this._scale;
				sliderTrackDefaultSkin.height = 198 * this._scale;
			}
			else //horizontal
			{
				sliderTrackDefaultSkin.width = 198 * this._scale;
				sliderTrackDefaultSkin.height = 66 * this._scale;
			}
			slider.minimumTrackProperties.defaultSkin = sliderTrackDefaultSkin;
		}

		protected function toggleSwitchInitializer(toggleSwitch:ToggleSwitch):void
		{
			toggleSwitch.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_SINGLE;

			const trackSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_SKIN_TEXTURES, this._scale);
			trackSkin.width = 148 * this._scale;
			trackSkin.height = 66 * this._scale;
			toggleSwitch.onTrackSkin = trackSkin;

			toggleSwitch.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			toggleSwitch.onTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);
		}

		protected function checkInitializer(check:Check):void
		{
			const iconManager:Scale9ImageStateValueManager = new Scale9ImageStateValueManager();
			iconManager.defaultValue = INSET_BACKGROUND_SKIN_TEXTURES;
			iconManager.defaultSelectedValue = CHECK_SELECTED_ICON_TEXTURES;
			iconManager.imageProperties =
			{
				width: 40 * this._scale,
				height: 40 * this._scale,
				textureScale: this._scale
			};
			check.stateToIconFunction = iconManager.updateValue;

			check.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			check.defaultSelectedTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);

			check.minTouchWidth = check.minTouchHeight = 88 * this._scale;
			check.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			check.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
		}

		protected function radioInitializer(radio:Radio):void
		{
			const iconManager:ImageStateValueManager = new ImageStateValueManager();
			iconManager.defaultValue = RADIO_ICON_TEXTURE;
			iconManager.defaultSelectedValue = RADIO_SELECTED_ICON_TEXTURE;
			iconManager.imageProperties =
			{
				scaleX: this._scale,
				scaleY: this._scale,
				textureScale: this._scale
			};
			radio.stateToIconFunction = iconManager.updateValue;

			radio.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			radio.defaultSelectedTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);

			radio.minTouchWidth = radio.minTouchHeight = 88 * this._scale;
			radio.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			radio.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
		}

		protected function itemRendererInitializer(renderer:BaseDefaultItemRenderer):void
		{
			const skinManager:ImageStateValueManager = new ImageStateValueManager();
			skinManager.defaultValue = LIST_ITEM_UP_TEXTURE;
			skinManager.defaultSelectedValue = LIST_ITEM_SELECTED_TEXTURE;
			skinManager.setValueForState(Button.STATE_DOWN, LIST_ITEM_DOWN_TEXTURE);
			skinManager.imageProperties =
			{
				width: 88 * this._scale,
				height: 88 * this._scale,
				smoothing: TextureSmoothing.NONE
			};
			renderer.stateToSkinFunction = skinManager.updateValue;

			renderer.paddingTop = renderer.paddingBottom = 11 * this._scale;
			renderer.paddingLeft = renderer.paddingRight = 16 * this._scale;
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.minWidth = renderer.minHeight = 88 * this._scale;
		}

		protected function headerOrFooterRendererInitializer(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
		{
			const backgroundSkin:Image = new Image(LIST_ITEM_DOWN_TEXTURE);
			backgroundSkin.smoothing = TextureSmoothing.NONE;
			backgroundSkin.width = 44 * this._scale;
			backgroundSkin.height = 44 * this._scale;
			renderer.backgroundSkin = backgroundSkin;

			renderer.paddingTop = renderer.paddingBottom = 6 * this._scale;
			renderer.paddingLeft = renderer.paddingRight = 16 * this._scale;
			renderer.minWidth = renderer.minHeight = 44 * this._scale;
		}

		protected function pickerListInitializer(list:PickerList):void
		{
			if(PhysicalCapabilities.isTablet(Starling.current.nativeStage))
			{
				list.popUpContentManager = new CalloutPopUpContentManager();
			}
			else
			{
				const centerStage:VerticalCenteredPopUpContentManager = new VerticalCenteredPopUpContentManager();
				centerStage.marginTop = centerStage.marginRight = centerStage.marginBottom =
					centerStage.marginLeft = 16 * this._scale;
				list.popUpContentManager = centerStage;
			}

			const layout:VerticalLayout = new VerticalLayout();
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_BOTTOM;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
			layout.useVirtualLayout = true;
			layout.gap = 0;
			layout.paddingTop = layout.paddingRight = layout.paddingBottom =
				layout.paddingLeft = 0;
			list.listProperties.layout = layout;

			if(PhysicalCapabilities.isTablet(Starling.current.nativeStage))
			{
				list.listProperties.minWidth = 10 * this._scale;
				list.listProperties.maxHeight = 352 * this._scale;
			}
			else
			{
				const backgroundSkin:Scale9Image = new Scale9Image(POPUP_BACKGROUND_SKIN_TEXTURES, this._scale);
				backgroundSkin.width = 20 * this._scale;
				backgroundSkin.height = 20 * this._scale;
				list.listProperties.backgroundSkin = backgroundSkin;
				list.listProperties.paddingTop = list.listProperties.paddingRight =
					list.listProperties.paddingBottom = list.listProperties.paddingLeft = 8 * this._scale;
			}
		}

		protected function screenHeaderInitializer(header:ScreenHeader):void
		{
			header.minWidth = 88 * this._scale;
			header.minHeight = 88 * this._scale;
			header.paddingTop = header.paddingRight = header.paddingBottom =
				header.paddingLeft = 14 * this._scale;
			const backgroundSkin:Scale9Image = new Scale9Image(HEADER_SKIN_TEXTURES, this._scale);
			backgroundSkin.width = 88 * this._scale;
			backgroundSkin.height = 88 * this._scale;
			header.backgroundSkin = backgroundSkin;
			header.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
		}

		protected function textInputInitializer(input:TextInput):void
		{
			input.minWidth = 88 * this._scale;
			input.minHeight = 88 * this._scale;
			input.paddingTop = input.paddingRight = input.paddingBottom =
				input.paddingLeft = 22 * this._scale;
			input.stageTextProperties.fontFamily = "Helvetica";
			input.stageTextProperties.fontSize = 36 * this._scale;
			input.stageTextProperties.color = INSET_TEXT_COLOR;

			const backgroundSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_SKIN_TEXTURES, this._scale);
			backgroundSkin.width = 264 * this._scale;
			backgroundSkin.height = 88 * this._scale;
			input.backgroundSkin = backgroundSkin;

			const backgroundDisabledSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_DISABLED_SKIN_TEXTURES, this._scale);
			backgroundDisabledSkin.width = 264 * this._scale;
			backgroundDisabledSkin.height = 88 * this._scale;
			input.backgroundDisabledSkin = backgroundDisabledSkin;
		}

		protected function progressBarInitializer(progress:ProgressBar):void
		{
			const backgroundSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_SKIN_TEXTURES, this._scale);
			backgroundSkin.width = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 264 : 22) * this._scale;
			backgroundSkin.height = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 22 : 264) * this._scale;
			progress.backgroundSkin = backgroundSkin;

			const backgroundDisabledSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_DISABLED_SKIN_TEXTURES, this._scale);
			backgroundDisabledSkin.width = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 264 : 22) * this._scale;
			backgroundDisabledSkin.height = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 22 : 264) * this._scale;
			progress.backgroundDisabledSkin = backgroundDisabledSkin;

			const fillSkin:Scale9Image = new Scale9Image(BUTTON_UP_SKIN_TEXTURES, this._scale);
			fillSkin.width = 12 * this._scale;
			fillSkin.height = 12 * this._scale;
			progress.fillSkin = fillSkin;

			const fillDisabledSkin:Scale9Image = new Scale9Image(BUTTON_DISABLED_SKIN_TEXTURES, this._scale);
			fillDisabledSkin.width = 12 * this._scale;
			fillDisabledSkin.height = 12 * this._scale;
			progress.fillDisabledSkin = fillDisabledSkin;
		}

		protected function calloutInitializer(callout:Callout):void
		{
			callout.minWidth = 20 * this._scale;
			callout.minHeight = 20 * this._scale;
			callout.paddingTop = callout.paddingRight = callout.paddingBottom =
				callout.paddingLeft = 8 * this._scale;
			const backgroundSkin:Scale9Image = new Scale9Image(POPUP_BACKGROUND_SKIN_TEXTURES, this._scale);
			backgroundSkin.width = 20 * this._scale;
			backgroundSkin.height = 20 * this._scale;
			callout.backgroundSkin = backgroundSkin;

			const topArrowSkin:Image = new Image(CALLOUT_TOP_ARROW_SKIN_TEXTURE);
			topArrowSkin.scaleX = topArrowSkin.scaleY = this._scale;
			callout.topArrowSkin = topArrowSkin;
			callout.topArrowGap = -4 * this._scale;

			const bottomArrowSkin:Image = new Image(CALLOUT_BOTTOM_ARROW_SKIN_TEXTURE);
			bottomArrowSkin.scaleX = bottomArrowSkin.scaleY = this._scale;
			callout.bottomArrowSkin = bottomArrowSkin;
			callout.bottomArrowGap = -4 * this._scale;

			const leftArrowSkin:Image = new Image(CALLOUT_LEFT_ARROW_SKIN_TEXTURE);
			leftArrowSkin.scaleX = leftArrowSkin.scaleY = this._scale;
			callout.leftArrowSkin = leftArrowSkin;
			callout.leftArrowGap = -4 * this._scale;

			const rightArrowSkin:Image = new Image(CALLOUT_RIGHT_ARROW_SKIN_TEXTURE);
			rightArrowSkin.scaleX = rightArrowSkin.scaleY = this._scale;
			callout.rightArrowSkin = rightArrowSkin;
			callout.rightArrowGap = -4 * this._scale;
		}

		protected function root_addedToStageHandler(event:Event):void
		{
			DisplayObject(event.currentTarget).stage.color = BACKGROUND_COLOR;
		}
	}
}