package com.ankamagames.dofus.misc.utils
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.misc.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.impl.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.display.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.net.*;
    import flash.system.*;
    import flash.text.*;

    public class LoadingScreen extends UiRootContainer implements FinalizableUIComponent, IResourceObserver
    {
        private var _loader:IResourceLoader;
        private var _logTf:TextField;
        private var _value:Number = 0;
        private var _levelColor:Array;
        private var _background:Class;
        private var _defaultBackground:Class;
        private var _bandeau_haut:Class;
        private var _bandeau_bas:Class;
        private var _foreground:Class;
        private var _defaultForeground:Class;
        private var _logoFr:Class;
        private var _logoJp:Class;
        private var _logoRu:Class;
        private var _dofusProgress:Class;
        private var _tipsBackground:Class;
        private var _btnLog:Class;
        private var _btnContinue:Class;
        private var _progressClip:MovieClip;
        private var _backgroundBitmap:Bitmap;
        private var _foregroundBitmap:Bitmap;
        private var _backgroundContainer:Sprite;
        private var _foregroundContainer:Sprite;
        private var _tipsBackgroundBitmap:DisplayObject;
        private var _tipsTextField:TextField;
        private var _btnContinueClip:DisplayObject;
        private var _continueCallBack:Function;
        private var _showBigVersion:Boolean;
        private var _beforeLogin:Boolean;
        private var _customLoadingScreen:CustomLoadingScreen;
        public static const INFO:uint = 0;
        public static const IMPORTANT:uint = 1;
        public static const ERROR:uint = 2;
        public static const WARNING:uint = 3;
        public static const USE_FORGROUND:Boolean = true;

        public function LoadingScreen(param1:Boolean = false, param2:Boolean = false)
        {
            var adapter:BitmapAdapter;
            var showBigVersion:* = param1;
            var beforeLogin:* = param2;
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._levelColor = new Array(8158332, 9216860, 11556943, 16737792);
            this._background = LoadingScreen__background;
            this._defaultBackground = LoadingScreen__defaultBackground;
            this._bandeau_haut = LoadingScreen__bandeau_haut;
            this._bandeau_bas = LoadingScreen__bandeau_bas;
            this._foreground = LoadingScreen__foreground;
            this._defaultForeground = LoadingScreen__defaultForeground;
            this._logoFr = LoadingScreen__logoFr;
            this._logoJp = LoadingScreen__logoJp;
            this._logoRu = LoadingScreen__logoRu;
            this._dofusProgress = LoadingScreen__dofusProgress;
            this._tipsBackground = LoadingScreen__tipsBackground;
            this._btnLog = LoadingScreen__btnLog;
            this._btnContinue = LoadingScreen__btnContinue;
            super(null, null);
            this._showBigVersion = showBigVersion;
            this._beforeLogin = beforeLogin;
            this._customLoadingScreen = CustomLoadingScreenManager.getInstance().currentLoadingScreen;
            if (this._customLoadingScreen && this._customLoadingScreen.canBeReadOnScreen(beforeLogin))
            {
                try
                {
                    adapter = new BitmapAdapter();
                    if (this._customLoadingScreen.backgroundImg)
                    {
                        adapter.loadFromData(new Uri(this._customLoadingScreen.backgroundUrl), this._customLoadingScreen.backgroundImg, this, false);
                    }
                    adapter = new BitmapAdapter();
                    if (this._customLoadingScreen.foregroundImg)
                    {
                        adapter.loadFromData(new Uri(this._customLoadingScreen.foregroundUrl), this._customLoadingScreen.foregroundImg, this, false);
                    }
                    this._customLoadingScreen.dataStore = CustomLoadingScreenManager.getInstance().dataStore;
                    this._customLoadingScreen.isViewing();
                }
                catch (e:Error)
                {
                    _log.error("Failed to initialize custom loading screen : " + e);
                    _customLoadingScreen = null;
                    finalizeInitialization();
                }
            }
            else
            {
                this._customLoadingScreen = null;
            }
            this.finalizeInitialization();
            return;
        }// end function

        public function get finalized() : Boolean
        {
            return true;
        }// end function

        public function set finalized(param1:Boolean) : void
        {
            return;
        }// end function

        public function set value(param1:Number) : void
        {
            this._value = param1;
            this._progressClip.gotoAndStop(Math.round(param1) + 2);
            return;
        }// end function

        public function get value() : Number
        {
            return this._value;
        }// end function

        public function finalize() : void
        {
            return;
        }// end function

        private function finalizeInitialization() : void
        {
            var _loc_3:* = null;
            var _loc_6:* = null;
            this._logTf = new TextField();
            this._logTf.width = StageShareManager.startWidth;
            this._logTf.height = 500;
            this._logTf.x = 10;
            this._logTf.y = 300;
            var _loc_1:* = FontManager.initialized ? (FontManager.getInstance().getFontClassName("Tahoma")) : ("Tahoma");
            this._logTf.setTextFormat(new TextFormat(_loc_1));
            this._logTf.defaultTextFormat = new TextFormat(_loc_1);
            this._logTf.multiline = true;
            addChild(this._logTf);
            this._logTf.visible = false;
            this._backgroundContainer = new Sprite();
            if (this._customLoadingScreen && this._customLoadingScreen.linkUrl)
            {
                this._backgroundContainer.buttonMode = true;
                this._backgroundContainer.useHandCursor = true;
                this._backgroundContainer.addEventListener(MouseEvent.CLICK, this.onClick);
            }
            if (!this._backgroundBitmap && !this._customLoadingScreen)
            {
                this._backgroundBitmap = this._backgroundContainer.addChild(new Capabilities.language == "ja" ? (this._defaultBackground) : (this._background)) as Bitmap;
                this._backgroundBitmap.smoothing = true;
            }
            addChild(this._backgroundContainer);
            this._foregroundContainer = new Sprite();
            this._foregroundContainer.mouseEnabled = false;
            this._foregroundContainer.mouseChildren = false;
            addChild(new this._bandeau_haut);
            if (USE_FORGROUND)
            {
                if (!this._foregroundBitmap && !this._customLoadingScreen)
                {
                    this._foregroundBitmap = this._foregroundContainer.addChild(new Capabilities.language == "ja" ? (this._defaultForeground) : (this._foreground)) as Bitmap;
                    this._foregroundBitmap.smoothing = true;
                }
            }
            var _loc_2:* = new this._bandeau_bas();
            _loc_2.y = StageShareManager.startHeight - _loc_2.height;
            _loc_2.smoothing = true;
            addChild(_loc_2);
            this._tipsBackgroundBitmap = new this._tipsBackground();
            this._tipsBackgroundBitmap.x = 89;
            this._tipsBackgroundBitmap.y = 933;
            addChild(this._tipsBackgroundBitmap);
            this._tipsBackgroundBitmap.visible = false;
            this._tipsTextField = new TextField();
            this._tipsTextField.x = this._tipsBackgroundBitmap.x + 10;
            this._tipsTextField.y = this._tipsBackgroundBitmap.y + 10;
            this._tipsTextField.width = this._tipsBackgroundBitmap.width - 20;
            this._tipsTextField.height = this._tipsBackgroundBitmap.height;
            this._tipsTextField.defaultTextFormat = new TextFormat(_loc_1, 19, 10066329, null, null, null, null, null, "center");
            this._tipsTextField.embedFonts = true;
            this._tipsTextField.selectable = false;
            this._tipsTextField.visible = false;
            this._tipsTextField.multiline = true;
            this._tipsTextField.wordWrap = true;
            addChild(this._tipsTextField);
            addChild(this._foregroundContainer);
            switch(Capabilities.language)
            {
                case "ja":
                {
                    _loc_3 = new this._logoJp();
                    _loc_3.x = 8;
                    _loc_3.y = -30;
                    break;
                }
                case "ru":
                {
                    _loc_3 = new this._logoRu();
                    _loc_3.x = 8;
                    _loc_3.y = 8;
                    break;
                }
                default:
                {
                    _loc_3 = new this._logoFr();
                    _loc_3.x = 8;
                    _loc_3.y = -30;
                    break;
                }
            }
            _loc_3.smoothing = true;
            addChild(_loc_3);
            this._progressClip = new this._dofusProgress();
            this._progressClip.x = 608;
            this._progressClip.y = 821;
            var _loc_7:* = 0.5;
            this._progressClip.scaleY = 0.5;
            this._progressClip.scaleX = _loc_7;
            addChild(this._progressClip);
            var _loc_4:* = new TextField();
            new TextField().appendText("Dofus " + BuildInfos.BUILD_VERSION + "\n");
            _loc_4.appendText("Mode " + BuildTypeParser.getTypeName(BuildInfos.BUILD_TYPE) + "\n");
            _loc_4.appendText(BuildInfos.BUILD_DATE + "\n");
            _loc_4.appendText("Player " + Capabilities.version);
            _loc_4.height = 200;
            _loc_4.width = 300;
            _loc_4.selectable = false;
            _loc_4.setTextFormat(new TextFormat(_loc_1, null, null, null, null, null, null, null, "right"));
            _loc_4.textColor = 7829367;
            _loc_4.y = 5;
            _loc_4.x = StageShareManager.startWidth - _loc_4.width;
            addChild(_loc_4);
            var _loc_5:* = new this._btnLog();
            new this._btnLog().x = 5;
            _loc_5.y = StageShareManager.startHeight - _loc_5.height - 5;
            _loc_5.addEventListener(MouseEvent.CLICK, this.onLogClick);
            addChild(_loc_5);
            this._btnContinueClip = new this._btnContinue() as SimpleButton;
            this._btnContinueClip.x = this._progressClip.x + (this._progressClip.width - this._btnContinueClip.width) / 2;
            this._btnContinueClip.y = this._progressClip.y + this._progressClip.height + 30;
            this._btnContinueClip.addEventListener(MouseEvent.CLICK, this.onContinueClick);
            this._btnContinueClip.visible = false;
            addChild(this._btnContinueClip);
            graphics.beginFill(0);
            graphics.drawRect(0, 0, width, height);
            graphics.endFill();
            if (BuildInfos.BUILD_TYPE > BuildTypeEnum.RELEASE && this._showBigVersion)
            {
                _loc_6 = new TextField();
                _loc_6.appendText(BuildTypeParser.getTypeName(BuildInfos.BUILD_TYPE) + " version");
                _loc_6.x = 300;
                _loc_6.y = 30;
                _loc_6.width = 400;
                _loc_6.selectable = false;
                _loc_6.setTextFormat(new TextFormat(_loc_1, 30, BuildTypeParser.getTypeColor(BuildInfos.BUILD_TYPE), true));
                addChild(_loc_6);
            }
            iAmFinalized(this);
            return;
        }// end function

        public function log(param1:String, param2:uint) : void
        {
            var _loc_3:* = null;
            if (param2 == ERROR || param2 == WARNING)
            {
                _loc_3 = new ColorTransform();
                _loc_3.color = this._levelColor[param2];
                this._progressClip.transform.colorTransform = _loc_3;
                this.showLog(true);
            }
            this._logTf.htmlText = "<p><font color=\"#" + uint(this._levelColor[param2]).toString(16) + "\">" + param1 + "</font></p>" + this._logTf.htmlText;
            return;
        }// end function

        public function showLog(param1:Boolean) : void
        {
            if (this._foregroundBitmap)
            {
                this._foregroundBitmap.visible = !param1;
            }
            if (this._backgroundBitmap)
            {
                this._backgroundBitmap.visible = !param1;
            }
            this._logTf.visible = param1;
            return;
        }// end function

        public function hideTips() : void
        {
            this._tipsTextField.visible = false;
            this._tipsBackgroundBitmap.visible = false;
            return;
        }// end function

        public function set useEmbedFont(param1:Boolean) : void
        {
            this._tipsTextField.embedFonts = false;
            return;
        }// end function

        public function set tip(param1:String) : void
        {
            this._tipsTextField.visible = true;
            this._tipsBackgroundBitmap.visible = true;
            this._tipsTextField.htmlText = param1;
            return;
        }// end function

        public function set continueCallbak(param1:Function) : void
        {
            this._btnContinueClip.visible = true;
            this.showLog(true);
            this.hideTips();
            this._continueCallBack = param1;
            return;
        }// end function

        private function onLogClick(event:Event) : void
        {
            this.showLog(!this._logTf.visible);
            return;
        }// end function

        private function onContinueClick(event:Event) : void
        {
            this._continueCallBack();
            return;
        }// end function

        public function onLoaded(param1:Uri, param2:uint, param3) : void
        {
            if (this._customLoadingScreen)
            {
                switch(param1.toString())
                {
                    case new Uri(this._customLoadingScreen.backgroundUrl).toString():
                    {
                        if (this._backgroundBitmap)
                        {
                            this._backgroundContainer.removeChild(this._backgroundBitmap);
                        }
                        this._backgroundBitmap = new Bitmap(param3 as BitmapData);
                        this._backgroundBitmap.smoothing = true;
                        this._backgroundContainer.addChild(this._backgroundBitmap);
                        break;
                    }
                    case new Uri(this._customLoadingScreen.foregroundUrl).toString():
                    {
                        if (this._foregroundBitmap)
                        {
                            this._foregroundContainer.removeChild(this._foregroundBitmap);
                        }
                        this._foregroundBitmap = new Bitmap(param3 as BitmapData);
                        this._foregroundBitmap.smoothing = true;
                        this._foregroundContainer.addChild(this._foregroundBitmap);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function onClick(event:MouseEvent) : void
        {
            if (this._customLoadingScreen && this._customLoadingScreen.canBeReadOnScreen(this._beforeLogin) && this._customLoadingScreen.linkUrl)
            {
                navigateToURL(new URLRequest(this._customLoadingScreen.linkUrl));
            }
            return;
        }// end function

        public function onFailed(param1:Uri, param2:String, param3:uint) : void
        {
            _log.error("Failed to load custom loading screen picture (" + param1.toString() + ")");
            return;
        }// end function

        public function onProgress(param1:Uri, param2:uint, param3:uint) : void
        {
            return;
        }// end function

    }
}
