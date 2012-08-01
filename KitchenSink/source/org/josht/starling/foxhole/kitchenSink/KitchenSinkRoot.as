package org.josht.starling.foxhole.kitchenSink
{
	import com.gskinner.motion.easing.Cubic;

	import flash.ui.Mouse;

	import org.josht.starling.foxhole.controls.ScreenNavigator;
	import org.josht.starling.foxhole.controls.ScreenNavigatorItem;
	import org.josht.starling.foxhole.kitchenSink.data.ButtonSettings;
	import org.josht.starling.foxhole.kitchenSink.data.ListSettings;
	import org.josht.starling.foxhole.kitchenSink.data.SliderSettings;
	import org.josht.starling.foxhole.kitchenSink.screens.ButtonScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.ButtonSettingsScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.CalloutScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.GroupedListScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.ListScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.ListSettingsScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.MainMenuScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.PickerListScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.ProgressBarScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.SliderScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.SliderSettingsScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.TabBarScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.TextInputScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.ToggleScreen;
	import org.josht.starling.foxhole.themes.IFoxholeTheme;
	import org.josht.starling.foxhole.themes.MinimalTheme;
	import org.josht.starling.foxhole.transitions.ScreenSlidingStackTransitionManager;

	import starling.display.Sprite;
	import starling.events.Event;

	public class KitchenSinkRoot extends Sprite
	{
		private static const MAIN_MENU:String = "mainMenu";
		private static const BUTTON:String = "button";
		private static const BUTTON_SETTINGS:String = "buttonSettings";
		private static const CALLOUT:String = "callout";
		private static const GROUPED_LIST:String = "groupedList";
		private static const LIST:String = "list";
		private static const LIST_SETTINGS:String = "listSettings";
		private static const PICKER_LIST:String = "pickerList";
		private static const PROGRESS_BAR:String = "progressBar";
		private static const SLIDER:String = "slider";
		private static const SLIDER_SETTINGS:String = "sliderSettings";
		private static const TAB_BAR:String = "tabBar";
		private static const TEXT_INPUT:String = "textInput";
		private static const TOGGLES:String = "toggles";
		
		public function KitchenSinkRoot()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private var _theme:IFoxholeTheme;
		private var _navigator:ScreenNavigator;
		private var _transitionManager:ScreenSlidingStackTransitionManager;
		
		private function addedToStageHandler(event:Event):void
		{
			//this is supposed to be an example mobile app, but it is also shown
			//as a preview in Flash Player on the web. we're making a special
			//case to pretend that the web SWF is running in the theme's "ideal"
			//DPI. official themes usually target an iPhone Retina display.
			const isDesktop:Boolean = Mouse.supportsCursor;
			this._theme = new MinimalTheme(this.stage, !isDesktop);
			const originalThemeDPI:int = this._theme.originalDPI;
			
			this._navigator = new ScreenNavigator();
			this.addChild(this._navigator);
			
			this._navigator.addScreen(MAIN_MENU, new ScreenNavigatorItem(MainMenuScreen,
			{
				onButton: BUTTON,
				onCallout: CALLOUT,
				onGroupedList: GROUPED_LIST,
				onList: LIST,
				onPickerList: PICKER_LIST,
				onProgressBar: PROGRESS_BAR,
				onSlider: SLIDER,
				onTabBar: TAB_BAR,
				onTextInput: TEXT_INPUT,
				onToggles: TOGGLES
			},
			{
				//the screens can use the theme's original DPI to scale other
				//content by the same amount with the dpiScale property.
				originalDPI: originalThemeDPI
			}));

			const buttonSettings:ButtonSettings = new ButtonSettings();
			this._navigator.addScreen(BUTTON, new ScreenNavigatorItem(ButtonScreen,
			{
				onBack: MAIN_MENU,
				onSettings: BUTTON_SETTINGS
			},
			{
				settings: buttonSettings,
				originalDPI: originalThemeDPI
			}));

			this._navigator.addScreen(BUTTON_SETTINGS, new ScreenNavigatorItem(ButtonSettingsScreen,
			{
				onBack: BUTTON
			},
			{
				settings: buttonSettings,
				originalDPI: originalThemeDPI
			}));

			this._navigator.addScreen(CALLOUT, new ScreenNavigatorItem(CalloutScreen,
			{
				onBack: MAIN_MENU
			},
			{
				originalDPI: originalThemeDPI
			}));

			const sliderSettings:SliderSettings = new SliderSettings();
			this._navigator.addScreen(SLIDER, new ScreenNavigatorItem(SliderScreen,
			{
				onBack: MAIN_MENU,
				onSettings: SLIDER_SETTINGS
			},
			{
				settings: sliderSettings,
				originalDPI: originalThemeDPI
			}));

			this._navigator.addScreen(SLIDER_SETTINGS, new ScreenNavigatorItem(SliderSettingsScreen,
			{
				onBack: SLIDER
			},
			{
				settings: sliderSettings,
				originalDPI: originalThemeDPI
			}));
			
			this._navigator.addScreen(TOGGLES, new ScreenNavigatorItem(ToggleScreen,
			{
				onBack: MAIN_MENU
			},
			{
				originalDPI: originalThemeDPI
			}));

			this._navigator.addScreen(GROUPED_LIST, new ScreenNavigatorItem(GroupedListScreen,
			{
				onBack: MAIN_MENU
			},
			{
				originalDPI: originalThemeDPI
			}));

			const listSettings:ListSettings = new ListSettings();
			this._navigator.addScreen(LIST, new ScreenNavigatorItem(ListScreen,
			{
				onBack: MAIN_MENU,
				onSettings: LIST_SETTINGS
			},
			{
				settings: listSettings,
				originalDPI: originalThemeDPI
			}));

			this._navigator.addScreen(LIST_SETTINGS, new ScreenNavigatorItem(ListSettingsScreen,
			{
				onBack: LIST
			},
			{
				settings: listSettings,
				originalDPI: originalThemeDPI
			}));
			
			this._navigator.addScreen(PICKER_LIST, new ScreenNavigatorItem(PickerListScreen,
			{
				onBack: MAIN_MENU
			},
			{
				originalDPI: originalThemeDPI
			}));

			this._navigator.addScreen(TAB_BAR, new ScreenNavigatorItem(TabBarScreen,
			{
				onBack: MAIN_MENU
			},
			{
				originalDPI: originalThemeDPI
			}));

			this._navigator.addScreen(TEXT_INPUT, new ScreenNavigatorItem(TextInputScreen,
			{
				onBack: MAIN_MENU
			},
			{
				originalDPI: originalThemeDPI
			}));

			this._navigator.addScreen(PROGRESS_BAR, new ScreenNavigatorItem(ProgressBarScreen,
			{
				onBack: MAIN_MENU
			},
			{
				originalDPI: originalThemeDPI
			}));
			
			this._navigator.showScreen(MAIN_MENU);
			
			this._transitionManager = new ScreenSlidingStackTransitionManager(this._navigator);
			this._transitionManager.duration = 0.4;
			this._transitionManager.ease = Cubic.easeOut;
		}
	}
}