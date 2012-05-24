package org.josht.starling.foxhole.layoutExplorer.screens
{
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.Screen;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.controls.ScrollContainer;
	import org.josht.starling.foxhole.layout.TiledColumnsLayout;
	import org.josht.starling.foxhole.layoutExplorer.data.TiledColumnsLayoutSettings;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;

	public class TiledColumnsLayoutScreen extends Screen
	{
		public function TiledColumnsLayoutScreen()
		{
			super();
		}

		public var settings:TiledColumnsLayoutSettings;

		private var _container:ScrollContainer;
		private var _header:ScreenHeader;
		private var _backButton:Button;
		private var _settingsButton:Button;

		private var _onBack:Signal = new Signal(TiledColumnsLayoutScreen);

		public function get onBack():ISignal
		{
			return this._onBack;
		}

		private var _onSettings:Signal = new Signal(TiledColumnsLayoutScreen);

		public function get onSettings():ISignal
		{
			return this._onSettings;
		}

		override protected function initialize():void
		{
			const layout:TiledColumnsLayout = new TiledColumnsLayout();
			layout.gap = this.settings.gap;
			layout.paddingTop = this.settings.paddingTop;
			layout.paddingRight = this.settings.paddingRight;
			layout.paddingBottom = this.settings.paddingBottom;
			layout.paddingLeft = this.settings.paddingLeft;
			layout.horizontalAlign = this.settings.horizontalAlign;
			layout.verticalAlign = this.settings.verticalAlign;
			layout.tileHorizontalAlign = this.settings.tileHorizontalAlign;
			layout.tileVerticalAlign = this.settings.tileVerticalAlign;

			this._container = new ScrollContainer();
			this._container.layout = layout;
			this.addChild(this._container);
			for(var i:int = 0; i < this.settings.itemCount; i++)
			{
				var button:Button = new Button();
				button.label = (i + 1).toString();
				button.width = button.height = (44 + 88 * Math.random()) * this.dpiScale;
				this._container.addChild(button);
			}

			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);

			this._settingsButton = new Button();
			this._settingsButton.label = "Settings";
			this._settingsButton.onRelease.add(settingsButton_onRelease);

			this._header = new ScreenHeader();
			this._header.title = "Tiled Columns Layout";
			this.addChild(this._header);
			this._header.leftItems = new <DisplayObject>
			[
				this._backButton
			];
			this._header.rightItems = new <DisplayObject>
			[
				this._settingsButton
			];

			// handles the back hardware key on android
			this.backButtonHandler = this.onBackButton;
		}

		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._header.validate();

			this._container.y = this._header.height;
			this._container.width = this.actualWidth;
			this._container.height = this.actualHeight - this._container.y;
		}

		private function onBackButton():void
		{
			this._onBack.dispatch(this);
		}

		private function backButton_onRelease(button:Button):void
		{
			this.onBackButton();
		}

		private function settingsButton_onRelease(button:Button):void
		{
			this._onSettings.dispatch(this);
		}
	}
}
