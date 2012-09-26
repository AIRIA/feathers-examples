/*
 Copyright (c) 2012 Josh Tynjala

 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */
package feathers.themes
{
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.Check;
	import feathers.controls.GroupedList;
	import feathers.controls.List;
	import feathers.controls.PickerList;
	import feathers.controls.ProgressBar;
	import feathers.controls.Radio;
	import feathers.controls.Header;
	import feathers.controls.ScrollBar;
	import feathers.controls.Scroller;
	import feathers.controls.SimpleScrollBar;
	import feathers.controls.Slider;
	import feathers.controls.TextInput;
	import feathers.controls.ToggleSwitch;
	import feathers.controls.popups.DropDownPopUpContentManager;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.text.BitmapFontTextRenderer;
	import feathers.core.DisplayListWatcher;
	import feathers.core.FeathersControl;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.skins.IFeathersTheme;
	import feathers.text.BitmapFontTextFormat;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;

	import flash.geom.Rectangle;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class AeonDesktopTheme extends DisplayListWatcher implements IFeathersTheme
	{
		[Embed(source="/../assets/images/aeon.png")]
		protected static const ATLAS_IMAGE:Class;

		[Embed(source="/../assets/images/aeon.xml",mimeType="application/octet-stream")]
		protected static const ATLAS_XML:Class;

		[Embed(source="/../assets/images/aeon/arial.fnt",mimeType="application/octet-stream")]
		protected static const FONT_XML:Class;

		protected static const BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(6, 6, 70, 10);
		protected static const SELECTED_BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(6, 6, 52, 10);
		protected static const HSLIDER_FIRST_REGION:Number = 2;
		protected static const HSLIDER_SECOND_REGION:Number = 75;
		protected static const TEXT_INPUT_SCALE_9_GRID:Rectangle = new Rectangle(2, 2, 148, 18);
		protected static const VERTICAL_SCROLL_BAR_THUMB_SCALE_9_GRID:Rectangle = new Rectangle(2, 5, 6, 42);
		protected static const VERTICAL_SCROLL_BAR_TRACK_SCALE_9_GRID:Rectangle = new Rectangle(2, 1, 11, 2);
		protected static const VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(2, 2, 11, 10);
		protected static const HORIZONTAL_SCROLL_BAR_THUMB_SCALE_9_GRID:Rectangle = new Rectangle(5, 2, 42, 6);
		protected static const HORIZONTAL_SCROLL_BAR_TRACK_SCALE_9_GRID:Rectangle = new Rectangle(1, 2, 2, 11);
		protected static const HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(2, 2, 10, 11);
		protected static const SIMPLE_BORDER_SCALE_9_GRID:Rectangle = new Rectangle(2, 2, 2, 2);
		protected static const PANEL_BORDER_SCALE_9_GRID:Rectangle = new Rectangle(6, 6, 2, 2);
		protected static const HEADER_SCALE_9_GRID:Rectangle = new Rectangle(0, 0, 4, 28);

		protected static const BACKGROUND_COLOR:uint = 0x869CA7;
		protected static const PRIMARY_TEXT_COLOR:uint = 0x0B333C;

		protected static function verticalScrollBarFactory():ScrollBar
		{
			const scrollBar:ScrollBar = new ScrollBar();
			scrollBar.direction = ScrollBar.DIRECTION_VERTICAL;
			return scrollBar;
		}

		protected static function horizontalScrollBarFactory():ScrollBar
		{
			const scrollBar:ScrollBar = new ScrollBar();
			scrollBar.direction = ScrollBar.DIRECTION_HORIZONTAL;
			return scrollBar;
		}

		public function AeonDesktopTheme(root:DisplayObjectContainer)
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
			this.initialize();
		}

		protected var fontSize:Number;

		public function get originalDPI():int
		{
			return 72;
		}

		public function get scaleToDPI():Boolean
		{
			return false;
		}

		protected var atlas:TextureAtlas;

		protected var bitmapFont:BitmapFont;

		protected var buttonUpSkinTextures:Scale9Textures;
		protected var buttonHoverSkinTextures:Scale9Textures;
		protected var buttonDownSkinTextures:Scale9Textures;
		protected var buttonDisabledSkinTextures:Scale9Textures;
		protected var buttonSelectedUpSkinTextures:Scale9Textures;
		protected var buttonSelectedHoverSkinTextures:Scale9Textures;
		protected var buttonSelectedDownSkinTextures:Scale9Textures;
		protected var buttonSelectedDisabledSkinTextures:Scale9Textures;

		protected var hSliderThumbUpSkinTexture:Texture;
		protected var hSliderThumbHoverSkinTexture:Texture;
		protected var hSliderThumbDownSkinTexture:Texture;
		protected var hSliderThumbDisabledSkinTexture:Texture;
		protected var hSliderTrackSkinTextures:Scale3Textures;

		protected var vSliderThumbUpSkinTexture:Texture;
		protected var vSliderThumbHoverSkinTexture:Texture;
		protected var vSliderThumbDownSkinTexture:Texture;
		protected var vSliderThumbDisabledSkinTexture:Texture;
		protected var vSliderTrackSkinTextures:Scale3Textures;

		protected var itemRendererUpSkinTexture:Texture;
		protected var itemRendererHoverSkinTexture:Texture;
		protected var itemRendererSelectedUpSkinTexture:Texture;

		protected var headerBackgroundSkinTextures:Scale9Textures;
		protected var groupedListHeaderBackgroundSkinTextures:Scale9Textures;

		protected var checkUpIconTexture:Texture;
		protected var checkHoverIconTexture:Texture;
		protected var checkDownIconTexture:Texture;
		protected var checkDisabledIconTexture:Texture;
		protected var checkSelectedUpIconTexture:Texture;
		protected var checkSelectedHoverIconTexture:Texture;
		protected var checkSelectedDownIconTexture:Texture;
		protected var checkSelectedDisabledIconTexture:Texture;

		protected var radioUpIconTexture:Texture;
		protected var radioHoverIconTexture:Texture;
		protected var radioDownIconTexture:Texture;
		protected var radioDisabledIconTexture:Texture;
		protected var radioSelectedUpIconTexture:Texture;
		protected var radioSelectedHoverIconTexture:Texture;
		protected var radioSelectedDownIconTexture:Texture;
		protected var radioSelectedDisabledIconTexture:Texture;

		protected var pickerListUpIconTexture:Texture;
		protected var pickerListHoverIconTexture:Texture;
		protected var pickerListDownIconTexture:Texture;
		protected var pickerListDisabledIconTexture:Texture;

		protected var textInputBackgroundSkinTextures:Scale9Textures;
		protected var textInputBackgroundDisabledSkinTextures:Scale9Textures;

		protected var vScrollBarThumbUpSkinTextures:Scale9Textures;
		protected var vScrollBarThumbHoverSkinTextures:Scale9Textures;
		protected var vScrollBarThumbDownSkinTextures:Scale9Textures;
		protected var vScrollBarTrackSkinTextures:Scale9Textures;
		protected var vScrollBarThumbIconTexture:Texture;
		protected var vScrollBarStepButtonUpSkinTextures:Scale9Textures;
		protected var vScrollBarStepButtonHoverSkinTextures:Scale9Textures;
		protected var vScrollBarStepButtonDownSkinTextures:Scale9Textures;
		protected var vScrollBarStepButtonDisabledSkinTextures:Scale9Textures;
		protected var vScrollBarDecrementButtonIconTexture:Texture;
		protected var vScrollBarIncrementButtonIconTexture:Texture;

		protected var hScrollBarThumbUpSkinTextures:Scale9Textures;
		protected var hScrollBarThumbHoverSkinTextures:Scale9Textures;
		protected var hScrollBarThumbDownSkinTextures:Scale9Textures;
		protected var hScrollBarTrackTextures:Scale9Textures;
		protected var hScrollBarThumbIconTexture:Texture;
		protected var hScrollBarStepButtonUpSkinTextures:Scale9Textures;
		protected var hScrollBarStepButtonHoverSkinTextures:Scale9Textures;
		protected var hScrollBarStepButtonDownSkinTextures:Scale9Textures;
		protected var hScrollBarStepButtonDisabledSkinTextures:Scale9Textures;
		protected var hScrollBarDecrementButtonIconTexture:Texture;
		protected var hScrollBarIncrementButtonIconTexture:Texture;

		protected var simpleBorderBackgroundSkinTextures:Scale9Textures;
		protected var panelBorderBackgroundSkinTextures:Scale9Textures;

		protected var progressBarFillSkinTexture:Texture;

		protected function initialize():void
		{
			Callout.stagePaddingTop = Callout.stagePaddingRight = Callout.stagePaddingBottom =
				Callout.stagePaddingLeft = 16;

			this.atlas = new TextureAtlas(Texture.fromBitmap(new ATLAS_IMAGE(), false), XML(new ATLAS_XML()));

			this.bitmapFont = new BitmapFont(atlas.getTexture("arial_0"), XML(new FONT_XML()));
			this.fontSize = this.bitmapFont.size;

			this.buttonUpSkinTextures = new Scale9Textures(atlas.getTexture("button-up-skin"), BUTTON_SCALE_9_GRID);
			this.buttonHoverSkinTextures = new Scale9Textures(atlas.getTexture("button-hover-skin"), BUTTON_SCALE_9_GRID);
			this.buttonDownSkinTextures = new Scale9Textures(atlas.getTexture("button-down-skin"), BUTTON_SCALE_9_GRID);
			this.buttonDisabledSkinTextures = new Scale9Textures(atlas.getTexture("button-disabled-skin"), BUTTON_SCALE_9_GRID);
			this.buttonSelectedUpSkinTextures = new Scale9Textures(atlas.getTexture("button-selected-up-skin"), SELECTED_BUTTON_SCALE_9_GRID);
			this.buttonSelectedHoverSkinTextures = new Scale9Textures(atlas.getTexture("button-selected-hover-skin"), SELECTED_BUTTON_SCALE_9_GRID);
			this.buttonSelectedDownSkinTextures = new Scale9Textures(atlas.getTexture("button-selected-down-skin"), SELECTED_BUTTON_SCALE_9_GRID);
			this.buttonSelectedDisabledSkinTextures = new Scale9Textures(atlas.getTexture("button-selected-disabled-skin"), SELECTED_BUTTON_SCALE_9_GRID);

			this.hSliderThumbUpSkinTexture = atlas.getTexture("hslider-thumb-up-skin");
			this.hSliderThumbHoverSkinTexture = atlas.getTexture("hslider-thumb-hover-skin");
			this.hSliderThumbDownSkinTexture = atlas.getTexture("hslider-thumb-down-skin");
			this.hSliderThumbDisabledSkinTexture = atlas.getTexture("hslider-thumb-disabled-skin");
			this.hSliderTrackSkinTextures = new Scale3Textures(atlas.getTexture("hslider-track-skin"), HSLIDER_FIRST_REGION, HSLIDER_SECOND_REGION, Scale3Textures.DIRECTION_HORIZONTAL);

			this.vSliderThumbUpSkinTexture = atlas.getTexture("vslider-thumb-up-skin");
			this.vSliderThumbHoverSkinTexture = atlas.getTexture("vslider-thumb-hover-skin");
			this.vSliderThumbDownSkinTexture = atlas.getTexture("vslider-thumb-down-skin");
			this.vSliderThumbDisabledSkinTexture = atlas.getTexture("vslider-thumb-disabled-skin");
			this.vSliderTrackSkinTextures = new Scale3Textures(atlas.getTexture("vslider-track-skin"), HSLIDER_FIRST_REGION, HSLIDER_SECOND_REGION, Scale3Textures.DIRECTION_VERTICAL);

			this.itemRendererUpSkinTexture = atlas.getTexture("item-renderer-up-skin");
			this.itemRendererHoverSkinTexture = atlas.getTexture("item-renderer-hover-skin");
			this.itemRendererSelectedUpSkinTexture = atlas.getTexture("item-renderer-selected-up-skin");

			this.headerBackgroundSkinTextures = new Scale9Textures(atlas.getTexture("header-background-skin"), HEADER_SCALE_9_GRID);
			this.groupedListHeaderBackgroundSkinTextures = new Scale9Textures(atlas.getTexture("grouped-list-header-background-skin"), HEADER_SCALE_9_GRID);

			this.checkUpIconTexture = atlas.getTexture("check-up-icon");
			this.checkHoverIconTexture = atlas.getTexture("check-hover-icon");
			this.checkDownIconTexture = atlas.getTexture("check-down-icon");
			this.checkDisabledIconTexture = atlas.getTexture("check-disabled-icon");
			this.checkSelectedUpIconTexture = atlas.getTexture("check-selected-up-icon");
			this.checkSelectedHoverIconTexture = atlas.getTexture("check-selected-hover-icon");
			this.checkSelectedDownIconTexture = atlas.getTexture("check-selected-down-icon");
			this.checkSelectedDisabledIconTexture = atlas.getTexture("check-selected-disabled-icon");

			this.radioUpIconTexture = atlas.getTexture("radio-up-icon");
			this.radioHoverIconTexture = atlas.getTexture("radio-hover-icon");
			this.radioDownIconTexture = atlas.getTexture("radio-down-icon");
			this.radioDisabledIconTexture = atlas.getTexture("radio-disabled-icon");
			this.radioSelectedUpIconTexture = atlas.getTexture("radio-selected-up-icon");
			this.radioSelectedHoverIconTexture = atlas.getTexture("radio-selected-hover-icon");
			this.radioSelectedDownIconTexture = atlas.getTexture("radio-selected-down-icon");
			this.radioSelectedDisabledIconTexture = atlas.getTexture("radio-selected-disabled-icon");

			this.pickerListUpIconTexture = atlas.getTexture("picker-list-up-icon");
			this.pickerListHoverIconTexture = atlas.getTexture("picker-list-hover-icon");
			this.pickerListDownIconTexture = atlas.getTexture("picker-list-down-icon");
			this.pickerListDisabledIconTexture = atlas.getTexture("picker-list-disabled-icon");

			this.textInputBackgroundSkinTextures = new Scale9Textures(atlas.getTexture("text-input-background-skin"), TEXT_INPUT_SCALE_9_GRID);
			this.textInputBackgroundDisabledSkinTextures = new Scale9Textures(atlas.getTexture("text-input-background-disabled-skin"), TEXT_INPUT_SCALE_9_GRID);

			this.vScrollBarThumbUpSkinTextures = new Scale9Textures(atlas.getTexture("vertical-scroll-bar-thumb-up-skin"), VERTICAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
			this.vScrollBarThumbHoverSkinTextures = new Scale9Textures(atlas.getTexture("vertical-scroll-bar-thumb-hover-skin"), VERTICAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
			this.vScrollBarThumbDownSkinTextures = new Scale9Textures(atlas.getTexture("vertical-scroll-bar-thumb-down-skin"), VERTICAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
			this.vScrollBarTrackSkinTextures = new Scale9Textures(atlas.getTexture("vertical-scroll-bar-track-skin"), VERTICAL_SCROLL_BAR_TRACK_SCALE_9_GRID);
			this.vScrollBarThumbIconTexture = atlas.getTexture("vertical-scroll-bar-thumb-icon");
			this.vScrollBarStepButtonUpSkinTextures = new Scale9Textures(atlas.getTexture("vertical-scroll-bar-step-button-up-skin"), VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
			this.vScrollBarStepButtonHoverSkinTextures = new Scale9Textures(atlas.getTexture("vertical-scroll-bar-step-button-hover-skin"), VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
			this.vScrollBarStepButtonDownSkinTextures = new Scale9Textures(atlas.getTexture("vertical-scroll-bar-step-button-down-skin"), VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
			this.vScrollBarStepButtonDisabledSkinTextures = new Scale9Textures(atlas.getTexture("vertical-scroll-bar-step-button-disabled-skin"), VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
			this.vScrollBarDecrementButtonIconTexture = atlas.getTexture("vertical-scroll-bar-decrement-button-icon");
			this.vScrollBarIncrementButtonIconTexture = atlas.getTexture("vertical-scroll-bar-increment-button-icon");

			this.hScrollBarThumbUpSkinTextures = new Scale9Textures(atlas.getTexture("horizontal-scroll-bar-thumb-up-skin"), HORIZONTAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
			this.hScrollBarThumbHoverSkinTextures = new Scale9Textures(atlas.getTexture("horizontal-scroll-bar-thumb-hover-skin"), HORIZONTAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
			this.hScrollBarThumbDownSkinTextures = new Scale9Textures(atlas.getTexture("horizontal-scroll-bar-thumb-down-skin"), HORIZONTAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
			this.hScrollBarTrackTextures = new Scale9Textures(atlas.getTexture("horizontal-scroll-bar-track-skin"), HORIZONTAL_SCROLL_BAR_TRACK_SCALE_9_GRID);
			this.hScrollBarThumbIconTexture = atlas.getTexture("horizontal-scroll-bar-thumb-icon");
			this.hScrollBarStepButtonUpSkinTextures = new Scale9Textures(atlas.getTexture("horizontal-scroll-bar-step-button-up-skin"), HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
			this.hScrollBarStepButtonHoverSkinTextures = new Scale9Textures(atlas.getTexture("horizontal-scroll-bar-step-button-hover-skin"), HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
			this.hScrollBarStepButtonDownSkinTextures = new Scale9Textures(atlas.getTexture("horizontal-scroll-bar-step-button-down-skin"), HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
			this.hScrollBarStepButtonDisabledSkinTextures = new Scale9Textures(atlas.getTexture("horizontal-scroll-bar-step-button-disabled-skin"), HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
			this.hScrollBarDecrementButtonIconTexture = atlas.getTexture("horizontal-scroll-bar-decrement-button-icon");
			this.hScrollBarIncrementButtonIconTexture = atlas.getTexture("horizontal-scroll-bar-increment-button-icon");

			this.simpleBorderBackgroundSkinTextures = new Scale9Textures(atlas.getTexture("simple-border-background-skin"), SIMPLE_BORDER_SCALE_9_GRID);
			this.panelBorderBackgroundSkinTextures = new Scale9Textures(atlas.getTexture("panel-background-skin"), PANEL_BORDER_SCALE_9_GRID);

			this.progressBarFillSkinTexture = atlas.getTexture("progress-bar-fill-skin");

			this.setInitializerForClass(BitmapFontTextRenderer, labelInitializer);
			this.setInitializerForClass(Button, buttonInitializer);
			this.setInitializerForClass(Button, toggleSwitchOnTrackInitializer, ToggleSwitch.DEFAULT_CHILD_NAME_ON_TRACK);
			this.setInitializerForClass(Button, toggleSwitchThumbInitializer, ToggleSwitch.DEFAULT_CHILD_NAME_THUMB);
			this.setInitializerForClass(Button, pickerListButtonInitializer, PickerList.DEFAULT_CHILD_NAME_BUTTON);
			this.setInitializerForClass(Button, nothingInitializer, SimpleScrollBar.DEFAULT_CHILD_NAME_THUMB);
			this.setInitializerForClass(Button, nothingInitializer, ScrollBar.DEFAULT_CHILD_NAME_THUMB);
			this.setInitializerForClass(Button, nothingInitializer, ScrollBar.DEFAULT_CHILD_NAME_DECREMENT_BUTTON);
			this.setInitializerForClass(Button, nothingInitializer, ScrollBar.DEFAULT_CHILD_NAME_INCREMENT_BUTTON);
			this.setInitializerForClass(Button, nothingInitializer, ScrollBar.DEFAULT_CHILD_NAME_MINIMUM_TRACK);
			this.setInitializerForClass(Button, nothingInitializer, ScrollBar.DEFAULT_CHILD_NAME_MAXIMUM_TRACK);
			this.setInitializerForClass(Button, nothingInitializer, Slider.DEFAULT_CHILD_NAME_THUMB);
			this.setInitializerForClass(Button, nothingInitializer, Slider.DEFAULT_CHILD_NAME_MINIMUM_TRACK);
			this.setInitializerForClass(Button, nothingInitializer, Slider.DEFAULT_CHILD_NAME_MAXIMUM_TRACK);
			this.setInitializerForClass(Check, checkInitializer);
			this.setInitializerForClass(Radio, radioInitializer);
			this.setInitializerForClass(ToggleSwitch, toggleSwitchInitializer);
			this.setInitializerForClass(Slider, sliderInitializer);
			this.setInitializerForClass(SimpleScrollBar, simpleScrollBarInitializer);
			this.setInitializerForClass(ScrollBar, scrollBarInitializer);
			this.setInitializerForClass(TextInput, textInputInitializer);
			this.setInitializerForClass(ProgressBar, progressBarInitializer);
			this.setInitializerForClass(Scroller, scrollerInitializer);
			this.setInitializerForClass(List, listInitializer);
			this.setInitializerForClass(List, nothingInitializer, PickerList.DEFAULT_CHILD_NAME_LIST);
			this.setInitializerForClass(GroupedList, groupedListInitializer);
			this.setInitializerForClass(PickerList, pickerListInitializer);
			this.setInitializerForClass(DefaultListItemRenderer, defaultItemRendererInitializer);
			this.setInitializerForClass(DefaultGroupedListItemRenderer, defaultItemRendererInitializer);
			this.setInitializerForClass(DefaultGroupedListHeaderOrFooterRenderer, defaultHeaderOrFooterRendererInitializer);
			this.setInitializerForClass(Header, headerInitializer);
			this.setInitializerForClass(Callout, calloutInitializer);
		}

		protected function nothingInitializer(target:FeathersControl):void
		{
			//do nothing
		}

		protected function labelInitializer(label:BitmapFontTextRenderer):void
		{
			label.textFormat = new BitmapFontTextFormat(bitmapFont, this.fontSize, PRIMARY_TEXT_COLOR);
		}

		protected function buttonInitializer(button:Button):void
		{
			button.defaultSkin = new Scale9Image(buttonUpSkinTextures);
			button.hoverSkin = new Scale9Image(buttonHoverSkinTextures);
			button.downSkin = new Scale9Image(buttonDownSkinTextures);
			button.disabledSkin = new Scale9Image(buttonDisabledSkinTextures);
			button.defaultSelectedSkin = new Scale9Image(buttonSelectedUpSkinTextures);
			button.selectedHoverSkin = new Scale9Image(buttonSelectedHoverSkinTextures);
			button.selectedDownSkin = new Scale9Image(buttonSelectedDownSkinTextures);
			button.selectedDisabledSkin = new Scale9Image(buttonSelectedDisabledSkinTextures);

			button.defaultLabelProperties.textFormat = new BitmapFontTextFormat(bitmapFont, this.fontSize, PRIMARY_TEXT_COLOR);

			button.paddingTop = button.paddingBottom = 2;
			button.paddingLeft = button.paddingRight = 10;
			button.gap = 2;
			button.minWidth = button.minHeight = 12;
		}

		protected function pickerListButtonInitializer(button:Button):void
		{
			this.buttonInitializer(button);

			button.defaultIcon = new Image(pickerListUpIconTexture);
			button.hoverIcon = new Image(pickerListHoverIconTexture);
			button.downIcon = new Image(pickerListDownIconTexture);
			button.disabledIcon = new Image(pickerListDisabledIconTexture);
			button.gap = Number.POSITIVE_INFINITY; //fill as completely as possible
			button.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			button.iconPosition = Button.ICON_POSITION_RIGHT;
			button.paddingRight = 6;
		}

		protected function toggleSwitchOnTrackInitializer(track:Button):void
		{
			track.defaultSkin = new Scale9Image(buttonSelectedUpSkinTextures);
		}

		protected function toggleSwitchThumbInitializer(thumb:Button):void
		{
			this.buttonInitializer(thumb);
			thumb.width = thumb.height = buttonUpSkinTextures.texture.frame.height;
		}

		protected function checkInitializer(check:Check):void
		{
			check.defaultIcon = new Image(checkUpIconTexture);
			check.hoverIcon = new Image(checkHoverIconTexture);
			check.downIcon = new Image(checkDownIconTexture);
			check.disabledIcon = new Image(checkDisabledIconTexture);
			check.defaultSelectedIcon = new Image(checkSelectedUpIconTexture);
			check.selectedHoverIcon = new Image(checkSelectedHoverIconTexture);
			check.selectedDownIcon = new Image(checkSelectedDownIconTexture);
			check.selectedDisabledIcon = new Image(checkSelectedDisabledIconTexture);

			check.defaultLabelProperties.textFormat = new BitmapFontTextFormat(bitmapFont, this.fontSize, PRIMARY_TEXT_COLOR);

			check.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			check.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
		}

		protected function radioInitializer(radio:Radio):void
		{
			radio.defaultIcon = new Image(radioUpIconTexture);
			radio.hoverIcon = new Image(radioHoverIconTexture);
			radio.downIcon = new Image(radioDownIconTexture);
			radio.disabledIcon = new Image(radioDisabledIconTexture);
			radio.defaultSelectedIcon = new Image(radioSelectedUpIconTexture);
			radio.selectedHoverIcon = new Image(radioSelectedHoverIconTexture);
			radio.selectedDownIcon = new Image(radioSelectedDownIconTexture);
			radio.selectedDisabledIcon = new Image(radioSelectedDisabledIconTexture);

			radio.defaultLabelProperties.textFormat = new BitmapFontTextFormat(bitmapFont, this.fontSize, PRIMARY_TEXT_COLOR);

			radio.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			radio.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
		}

		protected function toggleSwitchInitializer(toggle:ToggleSwitch):void
		{
			toggle.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_SINGLE;
			toggle.defaultLabelProperties.textFormat = new BitmapFontTextFormat(bitmapFont, this.fontSize, PRIMARY_TEXT_COLOR);
		}

		protected function sliderInitializer(slider:Slider):void
		{
			slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_SINGLE;
			slider.minimumPadding = slider.maximumPadding = -vSliderThumbUpSkinTexture.height / 2;

			if(slider.direction == Slider.DIRECTION_VERTICAL)
			{
				slider.thumbProperties.defaultSkin = new Image(vSliderThumbUpSkinTexture);
				slider.thumbProperties.hoverSkin = new Image(vSliderThumbHoverSkinTexture);
				slider.thumbProperties.downSkin = new Image(vSliderThumbDownSkinTexture);
				slider.thumbProperties.disabledSkin = new Image(vSliderThumbDisabledSkinTexture);
				slider.minimumTrackProperties.defaultSkin = new Scale3Image(vSliderTrackSkinTextures);
			}
			else //horizontal
			{
				slider.thumbProperties.defaultSkin = new Image(hSliderThumbUpSkinTexture);
				slider.thumbProperties.hoverSkin = new Image(hSliderThumbHoverSkinTexture);
				slider.thumbProperties.downSkin = new Image(hSliderThumbDownSkinTexture);
				slider.thumbProperties.disabledSkin = new Image(hSliderThumbDisabledSkinTexture);
				slider.minimumTrackProperties.defaultSkin = new Scale3Image(hSliderTrackSkinTextures);
			}
		}

		protected function simpleScrollBarInitializer(scrollBar:SimpleScrollBar):void
		{
			if(scrollBar.direction == Slider.DIRECTION_VERTICAL)
			{
				scrollBar.thumbProperties.defaultSkin = new Scale9Image(vScrollBarThumbUpSkinTextures);
				scrollBar.thumbProperties.hoverSkin = new Scale9Image(vScrollBarThumbHoverSkinTextures);
				scrollBar.thumbProperties.downSkin = new Scale9Image(vScrollBarThumbDownSkinTextures);
				scrollBar.thumbProperties.defaultIcon = new Image(vScrollBarThumbIconTexture);
				scrollBar.thumbProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
				scrollBar.thumbProperties.paddingLeft = 4;
			}
			else //horizontal
			{
				scrollBar.thumbProperties.defaultSkin = new Scale9Image(hScrollBarThumbUpSkinTextures);
				scrollBar.thumbProperties.hoverSkin = new Scale9Image(hScrollBarThumbHoverSkinTextures);
				scrollBar.thumbProperties.downSkin = new Scale9Image(hScrollBarThumbDownSkinTextures);
				scrollBar.thumbProperties.defaultIcon = new Image(hScrollBarThumbIconTexture);
				scrollBar.thumbProperties.verticalAlign = Button.VERTICAL_ALIGN_TOP;
				scrollBar.thumbProperties.paddingTop = 4;
			}
		}

		protected function scrollBarInitializer(scrollBar:ScrollBar):void
		{
			scrollBar.trackLayoutMode = ScrollBar.TRACK_LAYOUT_MODE_SINGLE;

			const decrementButtonDisabledIcon:Quad = new Quad(1, 1, 0xff00ff);
			decrementButtonDisabledIcon.alpha = 0;
			scrollBar.decrementButtonProperties.disabledIcon = decrementButtonDisabledIcon;

			const incrementButtonDisabledIcon:Quad = new Quad(1, 1, 0xff00ff);
			incrementButtonDisabledIcon.alpha = 0;
			scrollBar.incrementButtonProperties.disabledIcon = incrementButtonDisabledIcon;

			if(scrollBar.direction == Slider.DIRECTION_VERTICAL)
			{
				scrollBar.decrementButtonProperties.defaultSkin = new Scale9Image(vScrollBarStepButtonUpSkinTextures);
				scrollBar.decrementButtonProperties.hoverSkin = new Scale9Image(vScrollBarStepButtonHoverSkinTextures);
				scrollBar.decrementButtonProperties.downSkin = new Scale9Image(vScrollBarStepButtonDownSkinTextures);
				scrollBar.decrementButtonProperties.disabledSkin = new Scale9Image(vScrollBarStepButtonDisabledSkinTextures);
				scrollBar.decrementButtonProperties.defaultIcon = new Image(vScrollBarDecrementButtonIconTexture);

				scrollBar.incrementButtonProperties.defaultSkin = new Scale9Image(vScrollBarStepButtonUpSkinTextures);
				scrollBar.incrementButtonProperties.hoverSkin = new Scale9Image(vScrollBarStepButtonHoverSkinTextures);
				scrollBar.incrementButtonProperties.downSkin = new Scale9Image(vScrollBarStepButtonDownSkinTextures);
				scrollBar.incrementButtonProperties.disabledSkin = new Scale9Image(vScrollBarStepButtonDisabledSkinTextures);
				scrollBar.incrementButtonProperties.defaultIcon = new Image(vScrollBarIncrementButtonIconTexture);

				var thumbSkin:Scale9Image = new Scale9Image(vScrollBarThumbUpSkinTextures);
				thumbSkin.height = thumbSkin.width;
				scrollBar.thumbProperties.defaultSkin = thumbSkin;
				thumbSkin = new Scale9Image(vScrollBarThumbHoverSkinTextures);
				thumbSkin.height = thumbSkin.width;
				scrollBar.thumbProperties.hoverSkin = thumbSkin;
				thumbSkin = new Scale9Image(vScrollBarThumbDownSkinTextures);
				thumbSkin.height = thumbSkin.width;
				scrollBar.thumbProperties.downSkin = thumbSkin;
				scrollBar.thumbProperties.defaultIcon = new Image(vScrollBarThumbIconTexture);
				scrollBar.thumbProperties.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
				scrollBar.thumbProperties.paddingLeft = 4;

				scrollBar.minimumTrackProperties.defaultSkin = new Scale9Image(vScrollBarTrackSkinTextures);
			}
			else //horizontal
			{
				scrollBar.decrementButtonProperties.defaultSkin = new Scale9Image(hScrollBarStepButtonUpSkinTextures);
				scrollBar.decrementButtonProperties.hoverSkin = new Scale9Image(hScrollBarStepButtonHoverSkinTextures);
				scrollBar.decrementButtonProperties.downSkin = new Scale9Image(hScrollBarStepButtonDownSkinTextures);
				scrollBar.decrementButtonProperties.disabledSkin = new Scale9Image(hScrollBarStepButtonDisabledSkinTextures);
				scrollBar.decrementButtonProperties.defaultIcon = new Image(hScrollBarDecrementButtonIconTexture);

				scrollBar.incrementButtonProperties.defaultSkin = new Scale9Image(hScrollBarStepButtonUpSkinTextures);
				scrollBar.incrementButtonProperties.hoverSkin = new Scale9Image(hScrollBarStepButtonHoverSkinTextures);
				scrollBar.incrementButtonProperties.downSkin = new Scale9Image(hScrollBarStepButtonDownSkinTextures);
				scrollBar.incrementButtonProperties.disabledSkin = new Scale9Image(hScrollBarStepButtonDisabledSkinTextures);
				scrollBar.incrementButtonProperties.defaultIcon = new Image(hScrollBarIncrementButtonIconTexture);

				thumbSkin = new Scale9Image(hScrollBarThumbUpSkinTextures);
				thumbSkin.width = thumbSkin.height;
				scrollBar.thumbProperties.defaultSkin = thumbSkin;
				thumbSkin = new Scale9Image(hScrollBarThumbHoverSkinTextures);
				thumbSkin.width = thumbSkin.height;
				scrollBar.thumbProperties.hoverSkin = thumbSkin;
				thumbSkin = new Scale9Image(hScrollBarThumbDownSkinTextures);
				thumbSkin.width = thumbSkin.height;
				scrollBar.thumbProperties.downSkin = thumbSkin;
				scrollBar.thumbProperties.defaultIcon = new Image(hScrollBarThumbIconTexture);
				scrollBar.thumbProperties.verticalAlign = Button.VERTICAL_ALIGN_TOP;
				scrollBar.thumbProperties.paddingTop = 4;

				scrollBar.minimumTrackProperties.defaultSkin = new Scale9Image(hScrollBarTrackTextures);
			}
		}

		protected function textInputInitializer(input:TextInput):void
		{
			input.minWidth = input.minHeight = 22;
			input.paddingTop = input.paddingBottom = 2;
 			input.paddingRight = input.paddingLeft = 4;
			input.stageTextProperties.fontFamily = "Arial";
			input.stageTextProperties.fontSize = 11;
			input.stageTextProperties.color = PRIMARY_TEXT_COLOR;

			input.backgroundSkin = new Scale9Image(textInputBackgroundSkinTextures);
			input.backgroundDisabledSkin = new Scale9Image(textInputBackgroundDisabledSkinTextures);
		}

		protected function progressBarInitializer(progress:ProgressBar):void
		{
			const backgroundSkin:Scale9Image = new Scale9Image(simpleBorderBackgroundSkinTextures);
			backgroundSkin.width = backgroundSkin.height * 30;
			progress.backgroundSkin = backgroundSkin;
			progress.fillSkin = new Image(progressBarFillSkinTexture);

			progress.paddingTop = progress.paddingRight = progress.paddingBottom =
				progress.paddingLeft = 1;
		}

		protected function scrollerInitializer(scroller:Scroller):void
		{
			scroller.horizontalScrollBarFactory = horizontalScrollBarFactory;
			scroller.verticalScrollBarFactory = verticalScrollBarFactory;

			scroller.interactionMode = Scroller.INTERACTION_MODE_MOUSE;
			scroller.scrollBarDisplayMode = Scroller.SCROLL_BAR_DISPLAY_MODE_FIXED;
		}

		protected function listInitializer(list:List):void
		{
			list.backgroundSkin = new Scale9Image(simpleBorderBackgroundSkinTextures);

			list.paddingTop = list.paddingRight = list.paddingBottom =
				list.paddingLeft = 1;
		}

		protected function groupedListInitializer(list:GroupedList):void
		{
			list.backgroundSkin = new Scale9Image(simpleBorderBackgroundSkinTextures);

			list.paddingTop = list.paddingRight = list.paddingBottom =
				list.paddingLeft = 1;
		}

		protected function pickerListInitializer(list:PickerList):void
		{
			list.popUpContentManager = new DropDownPopUpContentManager();
			list.listProperties.maxHeight = 110;

			list.listProperties.backgroundSkin = new Scale9Image(simpleBorderBackgroundSkinTextures);

			list.listProperties.paddingTop = list.listProperties.paddingRight = list.listProperties.paddingBottom =
				list.listProperties.paddingLeft = 1;
		}

		protected function defaultItemRendererInitializer(renderer:BaseDefaultItemRenderer):void
		{
			renderer.defaultSkin = new Image(itemRendererUpSkinTexture);
			renderer.hoverSkin = new Image(itemRendererHoverSkinTexture);
			renderer.downSkin = new Image(itemRendererSelectedUpSkinTexture);
			renderer.defaultSelectedSkin = new Image(itemRendererSelectedUpSkinTexture);

			renderer.defaultLabelProperties.textFormat = new BitmapFontTextFormat(bitmapFont, this.fontSize, PRIMARY_TEXT_COLOR);

			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;

			renderer.paddingTop = renderer.paddingBottom = 2;
			renderer.paddingRight = renderer.paddingLeft = 6;
			renderer.gap = 2;
			renderer.minWidth = renderer.minHeight = 22;
		}

		protected function defaultHeaderOrFooterRendererInitializer(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
		{
			renderer.backgroundSkin = new Scale9Image(groupedListHeaderBackgroundSkinTextures);
			renderer.backgroundSkin.height = 18;

			renderer.paddingTop = renderer.paddingBottom = 2;
			renderer.paddingRight = renderer.paddingLeft = 6;
			renderer.minWidth = renderer.minHeight = 18;
		}

		protected function calloutInitializer(callout:Callout):void
		{
			callout.backgroundSkin = new Scale9Image(panelBorderBackgroundSkinTextures);
			const arrowSkin:Quad = new Quad(8, 8, 0xff00ff);
			arrowSkin.alpha = 0;
			callout.topArrowSkin =  callout.rightArrowSkin =  callout.bottomArrowSkin =
				callout.leftArrowSkin = arrowSkin;

			callout.paddingTop = callout.paddingBottom = 6;
			callout.paddingRight = callout.paddingLeft = 10;
		}

		protected function headerInitializer(header:Header):void
		{
			header.backgroundSkin = new Scale9Image(headerBackgroundSkinTextures);

			header.titleProperties.textFormat = new BitmapFontTextFormat(bitmapFont, this.fontSize, PRIMARY_TEXT_COLOR);

			header.paddingTop = header.paddingBottom = 2;
			header.paddingRight = header.paddingLeft = 6;
		}

		protected function root_addedToStageHandler(event:Event):void
		{
			DisplayObject(event.currentTarget).stage.color = BACKGROUND_COLOR;
		}
	}
}
