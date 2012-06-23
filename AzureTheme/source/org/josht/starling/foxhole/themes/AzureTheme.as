package org.josht.starling.foxhole.themes
{
	import flash.geom.Rectangle;
	import flash.system.Capabilities;

	import org.josht.starling.display.Image;
	import org.josht.starling.display.Scale3Image;
	import org.josht.starling.display.Scale9Image;
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.Callout;
	import org.josht.starling.foxhole.controls.Check;
	import org.josht.starling.foxhole.controls.Radio;
	import org.josht.starling.foxhole.controls.popups.CalloutPopUpContentManager;
	import org.josht.starling.foxhole.controls.DefaultItemRenderer;
	import org.josht.starling.foxhole.controls.FPSDisplay;
	import org.josht.starling.foxhole.controls.Label;
	import org.josht.starling.foxhole.controls.List;
	import org.josht.starling.foxhole.controls.PickerList;
	import org.josht.starling.foxhole.controls.ProgressBar;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.controls.SimpleScrollBar;
	import org.josht.starling.foxhole.controls.Slider;
	import org.josht.starling.foxhole.controls.TextInput;
	import org.josht.starling.foxhole.controls.ToggleSwitch;
	import org.josht.starling.foxhole.controls.popups.VerticalCenteredPopUpContentManager;
	import org.josht.starling.foxhole.core.AddedWatcher;
	import org.josht.starling.foxhole.layout.VerticalLayout;
	import org.josht.starling.foxhole.text.BitmapFontTextFormat;
	import org.josht.system.PhysicalCapabilities;

	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class AzureTheme extends AddedWatcher implements IFoxholeTheme
	{
		[Embed(source="/../assets/images/azure.png")]
		protected static const ATLAS_IMAGE:Class;

		[Embed(source="/../assets/images/azure.xml",mimeType="application/octet-stream")]
		protected static const ATLAS_XML:Class;

		protected static const ATLAS:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new ATLAS_IMAGE(), false), XML(new ATLAS_XML()));

		protected static const BUTTON_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("button-up-skin");
		protected static const BUTTON_DOWN_SKIN_TEXTURE:Texture = ATLAS.getTexture("button-down-skin");
		protected static const BUTTON_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("button-disabled-skin");

		protected static const HSLIDER_MINIMUM_TRACK_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("hslider-minimum-track-up-skin");
		protected static const HSLIDER_MINIMUM_TRACK_DOWN_SKIN_TEXTURE:Texture = ATLAS.getTexture("hslider-minimum-track-down-skin");
		protected static const HSLIDER_MINIMUM_TRACK_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("hslider-minimum-track-disabled-skin");

		protected static const HSLIDER_MAXIMUM_TRACK_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("hslider-maximum-track-up-skin");
		protected static const HSLIDER_MAXIMUM_TRACK_DOWN_SKIN_TEXTURE:Texture = ATLAS.getTexture("hslider-maximum-track-down-skin");
		protected static const HSLIDER_MAXIMUM_TRACK_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("hslider-maximum-track-disabled-skin");

		protected static const VSLIDER_MINIMUM_TRACK_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("vslider-minimum-track-up-skin");
		protected static const VSLIDER_MINIMUM_TRACK_DOWN_SKIN_TEXTURE:Texture = ATLAS.getTexture("vslider-minimum-track-down-skin");
		protected static const VSLIDER_MINIMUM_TRACK_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("vslider-minimum-track-disabled-skin");

		protected static const VSLIDER_MAXIMUM_TRACK_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("vslider-maximum-track-up-skin");
		protected static const VSLIDER_MAXIMUM_TRACK_DOWN_SKIN_TEXTURE:Texture = ATLAS.getTexture("vslider-maximum-track-down-skin");
		protected static const VSLIDER_MAXIMUM_TRACK_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("vslider-maximum-track-disabled-skin");

		protected static const SLIDER_THUMB_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("slider-thumb-up-skin");
		protected static const SLIDER_THUMB_DOWN_SKIN_TEXTURE:Texture = ATLAS.getTexture("slider-thumb-down-skin");
		protected static const SLIDER_THUMB_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("slider-thumb-disabled-skin");

		protected static const SCROLL_BAR_THUMB_SKIN_TEXTURE:Texture = ATLAS.getTexture("simple-scroll-bar-thumb-skin");

		protected static const PROGRESS_BAR_BACKGROUND_SKIN_TEXTURE:Texture = ATLAS.getTexture("progress-bar-background-skin");
		protected static const PROGRESS_BAR_BACKGROUND_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("progress-bar-background-disabled-skin");

		protected static const PROGRESS_BAR_FILL_SKIN_TEXTURE:Texture = ATLAS.getTexture("progress-bar-fill-skin");
		protected static const PROGRESS_BAR_FILL_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("progress-bar-fill-disabled-skin");

		protected static const INSET_BACKGROUND_SKIN_TEXTURE:Texture = ATLAS.getTexture("inset-skin");
		protected static const INSET_BACKGROUND_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("inset-disabled-skin");

		protected static const PICKER_ICON_TEXTURE:Texture = ATLAS.getTexture("picker-icon");

		protected static const LIST_ITEM_UP_TEXTURE:Texture = ATLAS.getTexture("list-item-up-skin");
		protected static const LIST_ITEM_DOWN_TEXTURE:Texture = ATLAS.getTexture("list-item-down-skin");

		protected static const TOOLBAR_BACKGROUND_SKIN_TEXTURE:Texture = ATLAS.getTexture("toolbar-background-skin");

		protected static const TAB_SELECTED_SKIN_TEXTURE:Texture = ATLAS.getTexture("tab-selected-skin");

		protected static const CALLOUT_BACKGROUND_SKIN_TEXTURE:Texture = ATLAS.getTexture("callout-background-skin");
		protected static const CALLOUT_TOP_ARROW_SKIN_TEXTURE:Texture = ATLAS.getTexture("callout-arrow-top-skin");
		protected static const CALLOUT_BOTTOM_ARROW_SKIN_TEXTURE:Texture = ATLAS.getTexture("callout-arrow-bottom-skin");
		protected static const CALLOUT_LEFT_ARROW_SKIN_TEXTURE:Texture = ATLAS.getTexture("callout-arrow-left-skin");
		protected static const CALLOUT_RIGHT_ARROW_SKIN_TEXTURE:Texture = ATLAS.getTexture("callout-arrow-right-skin");

		protected static const CHECK_UP_ICON_TEXTURE:Texture = ATLAS.getTexture("check-up-icon");
		protected static const CHECK_DOWN_ICON_TEXTURE:Texture = ATLAS.getTexture("check-down-icon");
		protected static const CHECK_DISABLED_ICON_TEXTURE:Texture = ATLAS.getTexture("check-disabled-icon");
		protected static const CHECK_SELECTED_UP_ICON_TEXTURE:Texture = ATLAS.getTexture("check-selected-up-icon");
		protected static const CHECK_SELECTED_DOWN_ICON_TEXTURE:Texture = ATLAS.getTexture("check-selected-down-icon");
		protected static const CHECK_SELECTED_DISABLED_ICON_TEXTURE:Texture = ATLAS.getTexture("check-selected-disabled-icon");

		protected static const RADIO_UP_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-up-icon");
		protected static const RADIO_DOWN_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-down-icon");
		protected static const RADIO_DISABLED_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-disabled-icon");
		protected static const RADIO_SELECTED_UP_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-selected-up-icon");
		protected static const RADIO_SELECTED_DISABLED_ICON_TEXTURE:Texture = ATLAS.getTexture("radio-selected-disabled-icon");

		[Embed(source="/../assets/fonts/lato30.fnt",mimeType="application/octet-stream")]
		protected static const ATLAS_FONT_XML:Class;

		protected static const BITMAP_FONT:BitmapFont = new BitmapFont(ATLAS.getTexture("lato30_0"), XML(new ATLAS_FONT_XML()));

		protected static const PROGRESS_BAR_SCALE_3_FIRST_REGION:Number = 12;
		protected static const PROGRESS_BAR_SCALE_3_SECOND_REGION:Number = 12;
		protected static const BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(8, 8, 15, 49);
		protected static const SLIDER_FIRST:Number = 16;
		protected static const SLIDER_SECOND:Number = 8;
		protected static const CALLOUT_SCALE_9_GRID:Rectangle = new Rectangle(8, 24, 15, 33);
		protected static const SCROLL_BAR_THUMB_SCALE_9_GRID:Rectangle = new Rectangle(4, 4, 4, 4);

		protected static const BACKGROUND_COLOR:uint = 0x13171a;
		protected static const PRIMARY_TEXT_COLOR:uint = 0xe5e5e5;
		protected static const SELECTED_TEXT_COLOR:uint = 0xffffff;

		protected static const ORIGINAL_DPI_IPHONE_RETINA:int = 326;
		protected static const ORIGINAL_DPI_IPAD_RETINA:int = 264;

		public function AzureTheme(root:DisplayObject, scaleToDPI:Boolean = true)
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
			this.initialize(scaleToDPI);
		}

		protected var _originalDPI:int;

		public function get originalDPI():int
		{
			return this._originalDPI;
		}

		protected var _scale:Number;
		protected var _fontSize:int;

		protected function initialize(scaleToDPI:Boolean):void
		{
			if(scaleToDPI)
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

			this._fontSize = 30 * this._scale;

			this.setInitializerForClass(Label, labelInitializer);
			this.setInitializerForClass(FPSDisplay, labelInitializer);
			this.setInitializerForClass(Button, buttonInitializer);
			this.setInitializerForClass(Slider, sliderInitializer);
			this.setInitializerForClass(SimpleScrollBar, scrollBarInitializer);
			this.setInitializerForClass(Check, checkInitializer);
			this.setInitializerForClass(Radio, radioInitializer);
			this.setInitializerForClass(ToggleSwitch, toggleSwitchInitializer);
			this.setInitializerForClass(List, listInitializer);
			this.setInitializerForClass(DefaultItemRenderer, itemRendererInitializer);
			this.setInitializerForClass(PickerList, pickerListInitializer);
			this.setInitializerForClass(ScreenHeader, screenHeaderInitializer);
			this.setInitializerForClass(TextInput, textInputInitializer);
			this.setInitializerForClass(ProgressBar, progressBarInitializer);
			this.setInitializerForClass(Callout, calloutInitializer);
		}

		protected function labelInitializer(label:Label):void
		{
			if(label.name)
			{
				return;
			}
			label.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
		}

		protected function buttonInitializer(button:Button):void
		{
			button.minTouchWidth = button.minTouchHeight = 88 * this._scale;
			if(button.nameList.contains("foxhole-tabbar-tab"))
			{
				const tabDefaultSkin:Image = new Image(TOOLBAR_BACKGROUND_SKIN_TEXTURE);
				tabDefaultSkin.width = 88 * this._scale;
				tabDefaultSkin.height = 88 * this._scale;
				button.defaultSkin = tabDefaultSkin;
				const tabDefaultSelectedSkin:Image = new Image(TAB_SELECTED_SKIN_TEXTURE);
				tabDefaultSelectedSkin.width = 88 * this._scale;
				tabDefaultSelectedSkin.height = 88 * this._scale;
				button.defaultSelectedSkin = tabDefaultSelectedSkin;
				button.downSkin = tabDefaultSelectedSkin;

				button.minWidth = 88 * this._scale;
				button.minHeight = 88 * this._scale;
				button.paddingTop = button.paddingRight = button.paddingBottom =
					button.paddingLeft = 16 * this._scale;
				button.gap = 12 * this._scale;
				button.iconPosition = Button.ICON_POSITION_TOP;

				button.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
				button.defaultSelectedTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);
			}
			else if(button.nameList.contains("foxhole-header-item"))
			{
				const toolbarDefaultSkin:Scale9Image = new Scale9Image(BUTTON_UP_SKIN_TEXTURE, BUTTON_SCALE_9_GRID, this._scale);
				toolbarDefaultSkin.width = 60 * this._scale;
				toolbarDefaultSkin.height = 60 * this._scale;
				button.defaultSkin = toolbarDefaultSkin;

				const toolbarDownSkin:Scale9Image = new Scale9Image(BUTTON_DOWN_SKIN_TEXTURE, BUTTON_SCALE_9_GRID, this._scale);
				toolbarDownSkin.width = 60 * this._scale;
				toolbarDownSkin.height = 60 * this._scale;
				button.downSkin = toolbarDownSkin;

				const toolbarDisabledSkin:Scale9Image = new Scale9Image(BUTTON_DISABLED_SKIN_TEXTURE, BUTTON_SCALE_9_GRID, this._scale);
				toolbarDisabledSkin.width = 60 * this._scale;
				toolbarDisabledSkin.height = 60 * this._scale;
				button.disabledSkin = toolbarDisabledSkin;

				button.defaultSelectedSkin = toolbarDownSkin;
				button.selectedDownSkin = toolbarDownSkin;

				button.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
				button.defaultSelectedTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);

				button.paddingTop = button.paddingBottom = 8 * this._scale;
				button.paddingLeft = button.paddingRight = 16 * this._scale;
				button.gap = 12 * this._scale;
				button.minWidth = 66 * this._scale;
				button.minHeight = 66 * this._scale;
			}
			else if(button.nameList.contains("foxhole-simple-scroll-bar-thumb"))
			{
				const scrollBarDefaultSkin:Scale9Image = new Scale9Image(SCROLL_BAR_THUMB_SKIN_TEXTURE, SCROLL_BAR_THUMB_SCALE_9_GRID, this._scale);
				scrollBarDefaultSkin.width = 8 * this._scale;
				scrollBarDefaultSkin.height = 8 * this._scale;
				button.defaultSkin = scrollBarDefaultSkin;
				button.minTouchWidth = button.minTouchHeight = 12 * this._scale;
			}
			else if(button.nameList.contains("foxhole-slider-thumb"))
			{
				const sliderThumbDefaultSkin:Image = new Image(SLIDER_THUMB_UP_SKIN_TEXTURE);
				sliderThumbDefaultSkin.width = 66 * this._scale;
				sliderThumbDefaultSkin.height = 66 * this._scale;
				button.defaultSkin = sliderThumbDefaultSkin;
				const sliderThumbDownSkin:Image = new Image(SLIDER_THUMB_DOWN_SKIN_TEXTURE);
				sliderThumbDownSkin.width = 66 * this._scale;
				sliderThumbDownSkin.height = 66 * this._scale;
				button.downSkin = sliderThumbDownSkin;
				const sliderThumbDisabledSkin:Image = new Image(SLIDER_THUMB_DISABLED_SKIN_TEXTURE);
				sliderThumbDisabledSkin.width = 66 * this._scale;
				sliderThumbDisabledSkin.height = 66 * this._scale;
				button.disabledSkin = sliderThumbDisabledSkin;
			}
			else if(button.nameList.contains("foxhole-slider-minimum-track") || button.nameList.contains("foxhole-slider-maximum-track"))
			{
				//do nothing. we're skinning them based on slider direction.
			}
			else
			{
				const defaultSkin:Scale9Image = new Scale9Image(BUTTON_UP_SKIN_TEXTURE, BUTTON_SCALE_9_GRID, this._scale);
				defaultSkin.width = 66 * this._scale;
				defaultSkin.height = 66 * this._scale;
				button.defaultSkin = defaultSkin;

				const downSkin:Scale9Image = new Scale9Image(BUTTON_DOWN_SKIN_TEXTURE, BUTTON_SCALE_9_GRID, this._scale);
				downSkin.width = 66 * this._scale;
				downSkin.height = 66 * this._scale;
				button.downSkin = downSkin;

				const disabledSkin:Scale9Image = new Scale9Image(BUTTON_DISABLED_SKIN_TEXTURE, BUTTON_SCALE_9_GRID, this._scale);
				disabledSkin.width = 66 * this._scale;
				disabledSkin.height = 66 * this._scale;
				button.disabledSkin = disabledSkin;

				button.defaultSelectedSkin = downSkin;

				button.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
				button.defaultSelectedTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);

				button.paddingTop = button.paddingBottom = 8 * this._scale;
				button.paddingLeft = button.paddingRight = 16 * this._scale;
				button.gap = 12 * this._scale;
				button.minWidth = 66 * this._scale;
				button.minHeight = 66 * this._scale;
			}

			//styles for the pickerlist button come from above, and then we're
			//adding a little bit extra.
			if(button.nameList.contains("foxhole-pickerlist-button"))
			{
				const pickerListButtonDefaultIcon:Image = new Image(PICKER_ICON_TEXTURE);
				pickerListButtonDefaultIcon.scaleX = pickerListButtonDefaultIcon.scaleY = this._scale;
				button.defaultIcon = pickerListButtonDefaultIcon
				button.gap = Number.POSITIVE_INFINITY; //fill as completely as possible
				button.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
				button.iconPosition = Button.ICON_POSITION_RIGHT;
			}
		}

		protected function sliderInitializer(slider:Slider):void
		{
			slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_STRETCH;
			if(slider.direction == Slider.DIRECTION_VERTICAL)
			{
				var sliderMinimumTrackDefaultSkin:Scale3Image = new Scale3Image(VSLIDER_MINIMUM_TRACK_UP_SKIN_TEXTURE, 0, SLIDER_SECOND, Scale3Image.DIRECTION_VERTICAL, this._scale);
				sliderMinimumTrackDefaultSkin.width *= this._scale;
				sliderMinimumTrackDefaultSkin.height = 198 * this._scale;
				var sliderMinimumTrackDownSkin:Scale3Image = new Scale3Image(VSLIDER_MINIMUM_TRACK_DOWN_SKIN_TEXTURE, 0, SLIDER_SECOND, Scale3Image.DIRECTION_VERTICAL, this._scale);
				sliderMinimumTrackDefaultSkin.width *= this._scale;
				sliderMinimumTrackDefaultSkin.height = 198 * this._scale;
				var sliderMinimumTrackDisabledSkin:Scale3Image = new Scale3Image(VSLIDER_MINIMUM_TRACK_DISABLED_SKIN_TEXTURE, 0, SLIDER_SECOND, Scale3Image.DIRECTION_VERTICAL, this._scale);
				sliderMinimumTrackDefaultSkin.width *= this._scale;
				sliderMinimumTrackDefaultSkin.height = 198 * this._scale;
				slider.minimumTrackProperties.defaultSkin = sliderMinimumTrackDefaultSkin;
				slider.minimumTrackProperties.downSkin = sliderMinimumTrackDownSkin;
				slider.minimumTrackProperties.disabledSkin = sliderMinimumTrackDisabledSkin;

				var sliderMaximumTrackDefaultSkin:Scale3Image = new Scale3Image(VSLIDER_MAXIMUM_TRACK_UP_SKIN_TEXTURE, SLIDER_FIRST, SLIDER_SECOND, Scale3Image.DIRECTION_VERTICAL, this._scale);
				sliderMaximumTrackDefaultSkin.width *= this._scale;
				sliderMaximumTrackDefaultSkin.height = 198 * this._scale;
				var sliderMaximumTrackDownSkin:Scale3Image = new Scale3Image(VSLIDER_MAXIMUM_TRACK_DOWN_SKIN_TEXTURE, SLIDER_FIRST, SLIDER_SECOND, Scale3Image.DIRECTION_VERTICAL, this._scale);
				sliderMaximumTrackDownSkin.width *= this._scale;
				sliderMaximumTrackDownSkin.height = 198 * this._scale;
				var sliderMaximumTrackDisabledSkin:Scale3Image = new Scale3Image(VSLIDER_MAXIMUM_TRACK_DISABLED_SKIN_TEXTURE, SLIDER_FIRST, SLIDER_SECOND, Scale3Image.DIRECTION_VERTICAL, this._scale);
				sliderMaximumTrackDisabledSkin.width *= this._scale;
				sliderMaximumTrackDisabledSkin.height = 198 * this._scale;
				slider.maximumTrackProperties.defaultSkin = sliderMaximumTrackDefaultSkin;
				slider.maximumTrackProperties.downSkin = sliderMaximumTrackDownSkin;
				slider.maximumTrackProperties.disabledSkin = sliderMaximumTrackDisabledSkin;
			}
			else //horizontal
			{
				sliderMinimumTrackDefaultSkin = new Scale3Image(HSLIDER_MINIMUM_TRACK_UP_SKIN_TEXTURE, SLIDER_FIRST, SLIDER_SECOND, Scale3Image.DIRECTION_HORIZONTAL, this._scale);
				sliderMinimumTrackDefaultSkin.width = 198 * this._scale;
				sliderMinimumTrackDefaultSkin.height *= this._scale;
				sliderMinimumTrackDownSkin = new Scale3Image(HSLIDER_MINIMUM_TRACK_DOWN_SKIN_TEXTURE, SLIDER_FIRST, SLIDER_SECOND, Scale3Image.DIRECTION_HORIZONTAL, this._scale);
				sliderMinimumTrackDefaultSkin.width = 198 * this._scale;
				sliderMinimumTrackDefaultSkin.height *= this._scale;
				sliderMinimumTrackDisabledSkin = new Scale3Image(HSLIDER_MINIMUM_TRACK_DISABLED_SKIN_TEXTURE, SLIDER_FIRST, SLIDER_SECOND, Scale3Image.DIRECTION_HORIZONTAL, this._scale);
				sliderMinimumTrackDefaultSkin.width = 198 * this._scale;
				sliderMinimumTrackDefaultSkin.height *= this._scale;
				slider.minimumTrackProperties.defaultSkin = sliderMinimumTrackDefaultSkin;
				slider.minimumTrackProperties.downSkin = sliderMinimumTrackDownSkin;
				slider.minimumTrackProperties.disabledSkin = sliderMinimumTrackDisabledSkin;

				sliderMaximumTrackDefaultSkin = new Scale3Image(HSLIDER_MAXIMUM_TRACK_UP_SKIN_TEXTURE, 0, SLIDER_SECOND, Scale3Image.DIRECTION_HORIZONTAL, this._scale);
				sliderMaximumTrackDefaultSkin.width = 198 * this._scale;
				sliderMaximumTrackDefaultSkin.height *= this._scale;
				sliderMaximumTrackDownSkin = new Scale3Image(HSLIDER_MAXIMUM_TRACK_DOWN_SKIN_TEXTURE, 0, SLIDER_SECOND, Scale3Image.DIRECTION_HORIZONTAL, this._scale);
				sliderMaximumTrackDownSkin.width = 198 * this._scale;
				sliderMaximumTrackDownSkin.height *= this._scale;
				sliderMaximumTrackDisabledSkin = new Scale3Image(HSLIDER_MAXIMUM_TRACK_DISABLED_SKIN_TEXTURE, SLIDER_FIRST, SLIDER_SECOND, Scale3Image.DIRECTION_HORIZONTAL, this._scale);
				sliderMaximumTrackDisabledSkin.width = 198 * this._scale;
				sliderMaximumTrackDisabledSkin.height *= this._scale;
				slider.maximumTrackProperties.defaultSkin = sliderMaximumTrackDefaultSkin;
				slider.maximumTrackProperties.downSkin = sliderMaximumTrackDownSkin;
				slider.maximumTrackProperties.disabledSkin = sliderMaximumTrackDisabledSkin;
			}
		}

		protected function scrollBarInitializer(scrollBar:SimpleScrollBar):void
		{
			scrollBar.paddingTop = scrollBar.paddingRight = scrollBar.paddingBottom =
				scrollBar.paddingLeft = 2 * this._scale;
		}

		protected function listInitializer(list:List):void
		{
			if(list.nameList.contains("foxhole-pickerlist-list"))
			{
				const layout:VerticalLayout = new VerticalLayout();
				layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_BOTTOM;
				layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
				layout.useVirtualLayout = true;
				layout.gap = 0;
				layout.paddingTop = layout.paddingRight = layout.paddingBottom =
					layout.paddingLeft = 0;
				list.layout = layout;

				if(PhysicalCapabilities.isTablet(Starling.current.nativeStage))
				{
					list.minWidth = 264 * this._scale;
					list.maxHeight = 352 * this._scale;
				}
				else
				{
					const backgroundSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_SKIN_TEXTURE, BUTTON_SCALE_9_GRID, this._scale);
					backgroundSkin.width = 20 * this._scale;
					backgroundSkin.height = 20 * this._scale;
					list.backgroundSkin = backgroundSkin;
					list.paddingTop = list.paddingRight = list.paddingBottom =
						list.paddingLeft = 8 * this._scale;
				}
			}
		}

		protected function checkInitializer(check:Check):void
		{
			const defaultIcon:Image = new Image(CHECK_UP_ICON_TEXTURE);
			defaultIcon.scaleX = defaultIcon.scaleY = this._scale;
			check.defaultIcon = defaultIcon;

			const downIcon:Image = new Image(CHECK_DOWN_ICON_TEXTURE);
			downIcon.scaleX = downIcon.scaleY = this._scale;
			check.downIcon = downIcon;

			const selectedDownIcon:Image = new Image(CHECK_SELECTED_DOWN_ICON_TEXTURE);
			selectedDownIcon.scaleX = selectedDownIcon.scaleY = this._scale;
			check.selectedDownIcon = selectedDownIcon;

			const disabledIcon:Image = new Image(CHECK_DISABLED_ICON_TEXTURE);
			disabledIcon.scaleX = disabledIcon.scaleY = this._scale;
			check.disabledIcon = disabledIcon;

			const defaultSelectedIcon:Image = new Image(CHECK_SELECTED_UP_ICON_TEXTURE);
			defaultSelectedIcon.scaleX = defaultSelectedIcon.scaleY = this._scale;
			check.defaultSelectedIcon = defaultSelectedIcon;

			const selectedDisabledIcon:Image = new Image(CHECK_SELECTED_DISABLED_ICON_TEXTURE);
			selectedDisabledIcon.scaleX = selectedDisabledIcon.scaleY = this._scale;
			check.selectedDisabledIcon = selectedDisabledIcon;

			check.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			check.defaultSelectedTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);

			check.minTouchWidth = check.minTouchHeight = 88 * this._scale;
			check.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			check.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
		}

		protected function radioInitializer(radio:Radio):void
		{
			const defaultIcon:Image = new Image(RADIO_UP_ICON_TEXTURE);
			defaultIcon.scaleX = defaultIcon.scaleY = this._scale;
			radio.defaultIcon = defaultIcon;

			const downIcon:Image = new Image(RADIO_DOWN_ICON_TEXTURE);
			downIcon.scaleX = downIcon.scaleY = this._scale;
			radio.downIcon = downIcon;

			const disabledIcon:Image = new Image(RADIO_DISABLED_ICON_TEXTURE);
			disabledIcon.scaleX = disabledIcon.scaleY = this._scale;
			radio.disabledIcon = disabledIcon;

			const defaultSelectedIcon:Image = new Image(RADIO_SELECTED_UP_ICON_TEXTURE);
			defaultSelectedIcon.scaleX = defaultSelectedIcon.scaleY = this._scale;
			radio.defaultSelectedIcon = defaultSelectedIcon;

			const selectedDisabledIcon:Image = new Image(RADIO_SELECTED_DISABLED_ICON_TEXTURE);
			selectedDisabledIcon.scaleX = selectedDisabledIcon.scaleY = this._scale;
			radio.selectedDisabledIcon = selectedDisabledIcon;

			radio.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			radio.defaultSelectedTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);

			radio.minTouchWidth = radio.minTouchHeight = 88 * this._scale;
			radio.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			radio.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
		}

		protected function toggleSwitchInitializer(toggleSwitch:ToggleSwitch):void
		{
			const onSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_SKIN_TEXTURE, BUTTON_SCALE_9_GRID, this._scale);
			onSkin.width = 148 * this._scale;
			onSkin.height = 66 * this._scale;
			toggleSwitch.onTrackSkin = onSkin;

			toggleSwitch.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_SINGLE;

			toggleSwitch.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			toggleSwitch.onTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);
		}

		protected function itemRendererInitializer(renderer:DefaultItemRenderer):void
		{
			const defaultSkin:Image = new Image(LIST_ITEM_UP_TEXTURE);
			defaultSkin.width = 88 * this._scale;
			defaultSkin.height = 88 * this._scale;
			defaultSkin.blendMode = BlendMode.NONE;
			renderer.defaultSkin = defaultSkin;

			const downSkin:Image = new Image(LIST_ITEM_DOWN_TEXTURE);
			downSkin.width = 88 * this._scale;
			downSkin.height = 88 * this._scale;
			downSkin.blendMode = BlendMode.NONE;
			renderer.downSkin = downSkin;

			renderer.defaultSelectedSkin = downSkin;

			renderer.paddingTop = renderer.paddingBottom = 11 * this._scale;
			renderer.paddingLeft = renderer.paddingRight = 20 * this._scale;
			renderer.minWidth = 88 * this._scale;
			renderer.minHeight = 88 * this._scale;

			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;

			renderer.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
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
		}

		protected function screenHeaderInitializer(header:ScreenHeader):void
		{
			const backgroundSkin:Image = new Image(TOOLBAR_BACKGROUND_SKIN_TEXTURE);
			backgroundSkin.width = 88 * this._scale;
			backgroundSkin.height = 88 * this._scale;
			backgroundSkin.blendMode = BlendMode.NONE;
			header.backgroundSkin = backgroundSkin;
			header.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			header.paddingTop = header.paddingRight = header.paddingBottom =
				header.paddingLeft = 14 * this._scale;
			header.minHeight = 88 * this._scale;
		}

		protected function textInputInitializer(input:TextInput):void
		{
			input.minWidth = 88 * this._scale;
			input.minHeight = 88 * this._scale;
			input.paddingTop = input.paddingRight = input.paddingBottom =
				input.paddingLeft = 22 * this._scale;
			input.stageTextProperties =
			{
				fontFamily: "Helvetica",
				fontSize: 36 * this._scale,
				color: 0xffffff
			};

			const backgroundSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_SKIN_TEXTURE, BUTTON_SCALE_9_GRID, this._scale);
			backgroundSkin.width = 264 * this._scale;
			backgroundSkin.height = 88 * this._scale;
			input.backgroundSkin = backgroundSkin;

			const backgroundDisabledSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_DISABLED_SKIN_TEXTURE, BUTTON_SCALE_9_GRID, this._scale);
			backgroundDisabledSkin.width = 264 * this._scale;
			backgroundDisabledSkin.height = 88 * this._scale;
			input.backgroundDisabledSkin = backgroundDisabledSkin;
		}

		protected function progressBarInitializer(progress:ProgressBar):void
		{
			const backgroundSkin:Scale3Image = new Scale3Image(PROGRESS_BAR_BACKGROUND_SKIN_TEXTURE, PROGRESS_BAR_SCALE_3_FIRST_REGION, PROGRESS_BAR_SCALE_3_SECOND_REGION, progress.direction, this._scale);
			backgroundSkin.width = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 264 : 24) * this._scale;
			backgroundSkin.height = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 24 : 264) * this._scale;
			progress.backgroundSkin = backgroundSkin;

			const backgroundDisabledSkin:Scale3Image = new Scale3Image(PROGRESS_BAR_BACKGROUND_DISABLED_SKIN_TEXTURE, PROGRESS_BAR_SCALE_3_FIRST_REGION, PROGRESS_BAR_SCALE_3_SECOND_REGION, progress.direction, this._scale);
			backgroundDisabledSkin.width = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 264 : 24) * this._scale;
			backgroundDisabledSkin.height = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 24 : 264) * this._scale;
			progress.backgroundDisabledSkin = backgroundDisabledSkin;

			const fillSkin:Scale3Image = new Scale3Image(PROGRESS_BAR_FILL_SKIN_TEXTURE, PROGRESS_BAR_SCALE_3_FIRST_REGION, PROGRESS_BAR_SCALE_3_SECOND_REGION, progress.direction, this._scale);
			fillSkin.width = 24 * this._scale;
			fillSkin.height = 24 * this._scale;
			progress.fillSkin = fillSkin;

			const fillDisabledSkin:Scale3Image = new Scale3Image(PROGRESS_BAR_FILL_DISABLED_SKIN_TEXTURE, PROGRESS_BAR_SCALE_3_FIRST_REGION, PROGRESS_BAR_SCALE_3_SECOND_REGION, progress.direction, this._scale);
			fillDisabledSkin.width = 24 * this._scale;
			fillDisabledSkin.height = 24 * this._scale;
			progress.fillDisabledSkin = fillDisabledSkin;
		}

		protected function calloutInitializer(callout:Callout):void
		{
			callout.paddingTop = callout.paddingRight = callout.paddingBottom =
				callout.paddingLeft = 16 * this._scale;

			const backgroundSkin:Scale9Image = new Scale9Image(CALLOUT_BACKGROUND_SKIN_TEXTURE, CALLOUT_SCALE_9_GRID, this._scale);
			backgroundSkin.width = 48 * this._scale;
			backgroundSkin.height = 48 * this._scale;
			callout.backgroundSkin = backgroundSkin;

			const topArrowSkin:Image = new Image(CALLOUT_TOP_ARROW_SKIN_TEXTURE);
			topArrowSkin.scaleX = topArrowSkin.scaleY = this._scale;
			callout.topArrowSkin = topArrowSkin;
			callout.topArrowGap = 0 * this._scale;

			const bottomArrowSkin:Image = new Image(CALLOUT_BOTTOM_ARROW_SKIN_TEXTURE);
			bottomArrowSkin.scaleX = bottomArrowSkin.scaleY = this._scale;
			callout.bottomArrowSkin = bottomArrowSkin;
			callout.bottomArrowGap = -1 * this._scale;

			const leftArrowSkin:Image = new Image(CALLOUT_LEFT_ARROW_SKIN_TEXTURE);
			leftArrowSkin.scaleX = leftArrowSkin.scaleY = this._scale;
			callout.leftArrowSkin = leftArrowSkin;
			callout.leftArrowGap = 0 * this._scale;

			const rightArrowSkin:Image = new Image(CALLOUT_RIGHT_ARROW_SKIN_TEXTURE);
			rightArrowSkin.scaleX = rightArrowSkin.scaleY = this._scale;
			callout.rightArrowSkin = rightArrowSkin;
			callout.rightArrowGap = -1 * this._scale;
		}

		protected function root_addedToStageHandler(event:Event):void
		{
			DisplayObject(event.currentTarget).stage.color = BACKGROUND_COLOR;
		}

	}
}