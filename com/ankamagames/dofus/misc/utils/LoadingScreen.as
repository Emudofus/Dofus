package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import flash.text.TextField;
   import flash.display.MovieClip;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.managers.FontManager;
   import flash.text.TextFormat;
   import flash.events.MouseEvent;
   import flash.system.Capabilities;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.misc.BuildTypeParser;
   import flash.display.SimpleButton;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.network.messages.game.achievement.AchievementListMessage;
   import com.ankamagames.dofus.datacenter.quest.AchievementCategory;
   import com.ankamagames.jerakine.data.I18n;
   import flash.text.TextFieldAutoSize;
   import flash.geom.ColorTransform;
   import flash.events.Event;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.BitmapData;
   import flash.net.navigateToURL;
   import flash.net.URLRequest;
   import com.ankamagames.dofus.kernel.Kernel;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.resources.adapters.impl.BitmapAdapter;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   
   public class LoadingScreen extends UiRootContainer implements FinalizableUIComponent, IResourceObserver
   {
      
      public function LoadingScreen(param1:Boolean=false, param2:Boolean=false) {
         var adapter:BitmapAdapter = null;
         var showBigVersion:Boolean = param1;
         var beforeLogin:Boolean = param2;
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
         this._levelColor = new Array(8158332,9216860,11556943,16737792);
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
         this._txProgressBar = LoadingScreen__txProgressBar;
         this._txProgressBarBackground = LoadingScreen__txProgressBarBackground;
         super(null,null);
         this._showBigVersion = showBigVersion;
         this._beforeLogin = beforeLogin;
         if((!beforeLogin) && (Kernel.getWorker()) && (ConnectionsHandler.getConnection()))
         {
            EnterFrameDispatcher.addEventListener(this.onEnterFrame,"loadingScreen");
            addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
         }
         this._customLoadingScreen = CustomLoadingScreenManager.getInstance().currentLoadingScreen;
         if((this._customLoadingScreen) && (this._customLoadingScreen.canBeReadOnScreen(beforeLogin)))
         {
            try
            {
               adapter = new BitmapAdapter();
               if(this._customLoadingScreen.backgroundImg)
               {
                  adapter.loadFromData(new Uri(this._customLoadingScreen.backgroundUrl),this._customLoadingScreen.backgroundImg,this,false);
               }
               adapter = new BitmapAdapter();
               if(this._customLoadingScreen.foregroundImg)
               {
                  adapter.loadFromData(new Uri(this._customLoadingScreen.foregroundUrl),this._customLoadingScreen.foregroundImg,this,false);
               }
               this._customLoadingScreen.dataStore = CustomLoadingScreenManager.getInstance().dataStore;
               this._customLoadingScreen.isViewing();
            }
            catch(e:Error)
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
         if((this._customLoadingScreen) && (this._customLoadingScreen.canBeReadOnScreen(beforeLogin)))
         {
            this.finalizeInitialization();
            return;
         }
         this.finalizeInitialization();
      }
      
      public static const INFO:uint = 0;
      
      public static const IMPORTANT:uint = 1;
      
      public static const ERROR:uint = 2;
      
      public static const WARNING:uint = 3;
      
      public static const USE_FORGROUND:Boolean = true;
      
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
      
      private var _txProgressBar:Class;
      
      private var _txProgressBarBackground:Class;
      
      private var _progressClip:MovieClip;
      
      private var _backgroundBitmap:Bitmap;
      
      private var _foregroundBitmap:Bitmap;
      
      private var _backgroundContainer:Sprite;
      
      private var _foregroundContainer:Sprite;
      
      private var _tipsBackgroundBitmap:DisplayObject;
      
      private var _tipsTextField:TextField;
      
      private var _achievementLabel:TextField;
      
      private var _achievementNumbersLabel:TextField;
      
      private var _btnContinueClip:DisplayObject;
      
      private var _continueCallBack:Function;
      
      private var _progressBar:DisplayObject;
      
      private var _progressBarBackground:DisplayObject;
      
      private var _showBigVersion:Boolean;
      
      private var _beforeLogin:Boolean;
      
      private var _customLoadingScreen:CustomLoadingScreen;
      
      private var _workerbufferSize:int = -1;
      
      private var _connectionBufferSize:int = -1;
      
      public function get finalized() : Boolean {
         return true;
      }
      
      public function set finalized(param1:Boolean) : void {
      }
      
      public function set value(param1:Number) : void {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param1 > 100)
         {
            param1 = 100;
         }
         Dofus.getInstance().strProgress = param1;
         this._value = param1;
         this._progressClip.gotoAndStop(Math.round(param1) + 2);
      }
      
      public function get value() : Number {
         return this._value;
      }
      
      public function finalize() : void {
      }
      
      private function finalizeInitialization() : void {
         var _loc3_:Bitmap = null;
         var _loc6_:TextField = null;
         this._logTf = new TextField();
         this._logTf.width = StageShareManager.startWidth;
         this._logTf.height = 500;
         this._logTf.x = 10;
         this._logTf.y = 300;
         var _loc1_:String = FontManager.initialized?FontManager.getInstance().getFontClassName("Tahoma"):"Tahoma";
         this._logTf.setTextFormat(new TextFormat(_loc1_));
         this._logTf.defaultTextFormat = new TextFormat(_loc1_);
         this._logTf.multiline = true;
         addChild(this._logTf);
         this._logTf.visible = false;
         this._backgroundContainer = new Sprite();
         if((this._customLoadingScreen) && (this._customLoadingScreen.linkUrl))
         {
            this._backgroundContainer.buttonMode = true;
            this._backgroundContainer.useHandCursor = true;
            this._backgroundContainer.addEventListener(MouseEvent.CLICK,this.onClick);
         }
         if(!this._backgroundBitmap && !this._customLoadingScreen)
         {
            this._backgroundBitmap = this._backgroundContainer.addChild(new Capabilities.language == "ja"?this._defaultBackground:this._background()) as Bitmap;
            this._backgroundBitmap.smoothing = true;
         }
         addChild(this._backgroundContainer);
         this._foregroundContainer = new Sprite();
         this._foregroundContainer.mouseEnabled = false;
         this._foregroundContainer.mouseChildren = false;
         addChild(new this._bandeau_haut());
         if(USE_FORGROUND)
         {
            if(!this._foregroundBitmap && !this._customLoadingScreen)
            {
               this._foregroundBitmap = this._foregroundContainer.addChild(new Capabilities.language == "ja"?this._defaultForeground:this._foreground()) as Bitmap;
               this._foregroundBitmap.smoothing = true;
            }
         }
         var _loc2_:Bitmap = new this._bandeau_bas();
         _loc2_.y = StageShareManager.startHeight - _loc2_.height;
         _loc2_.smoothing = true;
         addChild(_loc2_);
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
         this._tipsTextField.defaultTextFormat = new TextFormat(_loc1_,19,10066329,null,null,null,null,null,"center");
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
               _loc3_ = new this._logoJp();
               _loc3_.x = 8;
               _loc3_.y = -30;
               break;
            case "ru":
               _loc3_ = new this._logoRu();
               _loc3_.x = 8;
               _loc3_.y = 8;
               break;
            default:
               _loc3_ = new this._logoFr();
               _loc3_.x = 8;
               _loc3_.y = -30;
         }
         _loc3_.smoothing = true;
         addChild(_loc3_);
         this._progressClip = new this._dofusProgress();
         this._progressClip.x = 608;
         this._progressClip.y = 821;
         this._progressClip.scaleX = this._progressClip.scaleY = 0.5;
         addChild(this._progressClip);
         var _loc4_:TextField = new TextField();
         _loc4_.appendText("Dofus " + BuildInfos.BUILD_VERSION + "\n");
         _loc4_.appendText("Mode " + BuildTypeParser.getTypeName(BuildInfos.BUILD_TYPE) + "\n");
         _loc4_.appendText(BuildInfos.BUILD_DATE + "\n");
         _loc4_.appendText("Player " + Capabilities.version);
         _loc4_.height = 200;
         _loc4_.width = 300;
         _loc4_.selectable = false;
         _loc4_.setTextFormat(new TextFormat(_loc1_,null,null,null,null,null,null,null,"right"));
         _loc4_.textColor = 7829367;
         _loc4_.y = 5;
         _loc4_.x = StageShareManager.startWidth - _loc4_.width;
         addChild(_loc4_);
         var _loc5_:DisplayObject = new this._btnLog();
         _loc5_.x = 5;
         _loc5_.y = StageShareManager.startHeight - _loc5_.height - 5;
         _loc5_.addEventListener(MouseEvent.CLICK,this.onLogClick);
         addChild(_loc5_);
         this._btnContinueClip = new this._btnContinue() as SimpleButton;
         this._btnContinueClip.x = this._progressClip.x + (this._progressClip.width - this._btnContinueClip.width) / 2;
         this._btnContinueClip.y = this._progressClip.y + this._progressClip.height + 30;
         this._btnContinueClip.addEventListener(MouseEvent.CLICK,this.onContinueClick);
         this._btnContinueClip.visible = false;
         addChild(this._btnContinueClip);
         graphics.beginFill(0);
         graphics.drawRect(0,0,width,height);
         graphics.endFill();
         if(BuildInfos.BUILD_TYPE > BuildTypeEnum.RELEASE && (this._showBigVersion))
         {
            _loc6_ = new TextField();
            _loc6_.appendText(BuildTypeParser.getTypeName(BuildInfos.BUILD_TYPE) + " version");
            _loc6_.x = 300;
            _loc6_.y = 30;
            _loc6_.width = 400;
            _loc6_.selectable = false;
            _loc6_.setTextFormat(new TextFormat(_loc1_,30,BuildTypeParser.getTypeColor(BuildInfos.BUILD_TYPE),true));
            addChild(_loc6_);
         }
         iAmFinalized(this);
      }
      
      private function displayAchievmentProgressBar(param1:AchievementListMessage) : void {
         var _loc4_:* = NaN;
         var _loc5_:AchievementCategory = null;
         var _loc8_:AchievementCategory = null;
         var _loc9_:uint = 0;
         var _loc10_:String = null;
         var _loc2_:Array = AchievementCategory.getAchievementCategories();
         var _loc3_:* = false;
         while(!_loc3_)
         {
            _loc4_ = Math.round(Math.random() * (_loc2_.length-1));
            _loc5_ = _loc2_[_loc4_];
            if(_loc5_.parentId > 0)
            {
               _loc2_.splice(_loc4_,1);
            }
            else
            {
               _loc3_ = true;
            }
         }
         _loc2_ = AchievementCategory.getAchievementCategories();
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         for each (_loc8_ in _loc2_)
         {
            if(_loc8_.parentId == _loc5_.id || _loc8_.id == _loc5_.id)
            {
               for each (_loc9_ in _loc8_.achievementIds)
               {
                  if(param1.finishedAchievementsIds.indexOf(_loc9_) != -1)
                  {
                     _loc6_++;
                  }
                  _loc7_++;
               }
            }
         }
         this._progressBar = new this._txProgressBar();
         this._progressBarBackground = new this._txProgressBarBackground();
         this._achievementLabel = new TextField();
         this._achievementNumbersLabel = new TextField();
         this._tipsBackgroundBitmap.y = this._tipsBackgroundBitmap.y - 18;
         this._tipsBackgroundBitmap.height = this._tipsBackgroundBitmap.height - 200;
         this._tipsTextField.y = this._tipsBackgroundBitmap.y + 10;
         _loc10_ = FontManager.initialized?FontManager.getInstance().getFontClassName("Tahoma"):"Tahoma";
         this._achievementLabel.x = this._tipsBackgroundBitmap.x;
         this._achievementLabel.defaultTextFormat = new TextFormat(_loc10_,19,16777215,null,null,null,null,null,"center");
         this._achievementLabel.embedFonts = true;
         this._achievementLabel.selectable = false;
         this._achievementLabel.visible = true;
         this._achievementLabel.multiline = false;
         this._achievementLabel.text = I18n.getUiText("ui.achievement.achievement") + I18n.getUiText("ui.common.colon") + _loc5_.name;
         this._achievementLabel.autoSize = TextFieldAutoSize.LEFT;
         this._achievementNumbersLabel.defaultTextFormat = new TextFormat(_loc10_,19,16777215,null,null,null,null,null,"center");
         this._achievementNumbersLabel.embedFonts = true;
         this._achievementNumbersLabel.selectable = false;
         this._achievementNumbersLabel.visible = true;
         this._achievementNumbersLabel.multiline = false;
         this._achievementNumbersLabel.text = _loc6_ + " / " + _loc7_;
         this._achievementNumbersLabel.autoSize = TextFieldAutoSize.LEFT;
         this._achievementNumbersLabel.x = this._tipsBackgroundBitmap.x + this._tipsBackgroundBitmap.width - this._achievementNumbersLabel.width;
         this._progressBarBackground.height = -3;
         this._progressBarBackground.x = this._achievementLabel.x + this._achievementLabel.width + 5;
         this._progressBarBackground.y = this._tipsBackgroundBitmap.y + this._tipsBackgroundBitmap.height + 5;
         this._achievementLabel.y = this._progressBarBackground.y - this._achievementLabel.height / 4;
         this._achievementLabel.height = this._progressBarBackground.height;
         this._achievementNumbersLabel.height = this._progressBarBackground.height;
         this._achievementNumbersLabel.y = this._progressBarBackground.y - this._achievementNumbersLabel.height / 4;
         this._progressBar.x = this._progressBarBackground.x;
         this._progressBar.y = this._progressBarBackground.y;
         this._progressBarBackground.width = this._tipsBackgroundBitmap.x + this._tipsBackgroundBitmap.width - this._achievementNumbersLabel.width - this._progressBarBackground.x - 5;
         var _loc11_:ColorTransform = new ColorTransform();
         _loc11_.color = uint(_loc5_.color);
         this._progressBar.transform.colorTransform = _loc11_;
         var _loc12_:Number = _loc6_ / _loc7_;
         this._progressBar.width = _loc12_ * this._progressBarBackground.width;
         this._progressBar.visible = true;
         this._progressBarBackground.visible = true;
         addChild(this._progressBarBackground);
         addChild(this._progressBar);
         addChild(this._achievementLabel);
         addChild(this._achievementNumbersLabel);
      }
      
      public function log(param1:String, param2:uint) : void {
         var _loc3_:ColorTransform = null;
         if(param2 == ERROR || param2 == WARNING)
         {
            _loc3_ = new ColorTransform();
            _loc3_.color = this._levelColor[param2];
            this._progressClip.transform.colorTransform = _loc3_;
            this.showLog(true);
         }
         this._logTf.htmlText = "<p><font color=\"#" + uint(this._levelColor[param2]).toString(16) + "\">" + param1 + "</font></p>" + this._logTf.htmlText;
      }
      
      public function showLog(param1:Boolean) : void {
         if(this._foregroundBitmap)
         {
            this._foregroundBitmap.visible = !param1;
         }
         if(this._backgroundBitmap)
         {
            this._backgroundBitmap.visible = !param1;
         }
         this._logTf.visible = param1;
      }
      
      public function hideTips() : void {
         this._tipsTextField.visible = false;
         this._tipsBackgroundBitmap.visible = false;
      }
      
      public function set useEmbedFont(param1:Boolean) : void {
         this._tipsTextField.embedFonts = false;
      }
      
      public function set tip(param1:String) : void {
         this._tipsTextField.visible = true;
         this._tipsBackgroundBitmap.visible = true;
         this._tipsTextField.htmlText = param1;
      }
      
      public function set continueCallbak(param1:Function) : void {
         this._btnContinueClip.visible = true;
         this.showLog(true);
         this.hideTips();
         this._continueCallBack = param1;
      }
      
      private function onLogClick(param1:Event) : void {
         this.showLog(!this._logTf.visible);
      }
      
      private function onContinueClick(param1:Event) : void {
         this._continueCallBack();
      }
      
      public function onLoaded(param1:Uri, param2:uint, param3:*) : void {
         if(this._customLoadingScreen)
         {
            switch(param1.toString())
            {
               case new Uri(this._customLoadingScreen.backgroundUrl).toString():
                  if(this._backgroundBitmap)
                  {
                     this._backgroundContainer.removeChild(this._backgroundBitmap);
                  }
                  this._backgroundBitmap = new Bitmap(param3 as BitmapData);
                  this._backgroundBitmap.smoothing = true;
                  this._backgroundContainer.addChild(this._backgroundBitmap);
                  break;
               case new Uri(this._customLoadingScreen.foregroundUrl).toString():
                  if(this._foregroundBitmap)
                  {
                     this._foregroundContainer.removeChild(this._foregroundBitmap);
                  }
                  this._foregroundBitmap = new Bitmap(param3 as BitmapData);
                  this._foregroundBitmap.smoothing = true;
                  this._foregroundContainer.addChild(this._foregroundBitmap);
                  break;
            }
         }
      }
      
      public function onClick(param1:MouseEvent) : void {
         if((this._customLoadingScreen) && (this._customLoadingScreen.canBeReadOnScreen(this._beforeLogin)) && (this._customLoadingScreen.linkUrl))
         {
            navigateToURL(new URLRequest(this._customLoadingScreen.linkUrl));
         }
      }
      
      public function onFailed(param1:Uri, param2:String, param3:uint) : void {
         _log.error("Failed to load custom loading screen picture (" + param1.toString() + ")");
      }
      
      public function onProgress(param1:Uri, param2:uint, param3:uint) : void {
      }
      
      public function onEnterFrame(param1:Event) : void {
         var _loc5_:* = 0;
         var _loc2_:Vector.<Message> = Kernel.getWorker().pausedQueue;
         var _loc3_:Array = ConnectionsHandler.getConnection().getPauseBuffer();
         var _loc4_:AchievementListMessage = null;
         if(_loc2_.length > this._workerbufferSize)
         {
            if(this._workerbufferSize <= 0)
            {
               _loc5_ = 0;
            }
            else
            {
               _loc5_ = this._workerbufferSize-1;
            }
            this._workerbufferSize = _loc2_.length;
            while(_loc5_ < this._workerbufferSize)
            {
               if(_loc2_[_loc5_] is AchievementListMessage)
               {
                  _loc4_ = _loc2_[_loc5_] as AchievementListMessage;
                  break;
               }
               _loc5_++;
            }
         }
         if(!_loc4_ && _loc3_.length > this._connectionBufferSize)
         {
            if(this._connectionBufferSize <= 0)
            {
               _loc5_ = 0;
            }
            else
            {
               _loc5_ = this._connectionBufferSize-1;
            }
            this._connectionBufferSize = _loc3_.length;
            while(_loc5_ < this._connectionBufferSize)
            {
               if(_loc3_[_loc5_] is AchievementListMessage)
               {
                  _loc4_ = _loc3_[_loc5_] as AchievementListMessage;
                  break;
               }
               _loc5_++;
            }
         }
         if(_loc4_)
         {
            EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
            this.displayAchievmentProgressBar(_loc4_);
         }
      }
      
      private function onRemoveFromStage(param1:Event) : void {
         EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      }
   }
}
