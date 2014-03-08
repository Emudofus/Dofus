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
      
      public function LoadingScreen(showBigVersion:Boolean=false, beforeLogin:Boolean=false) {
         var adapter:BitmapAdapter = null;
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
      
      public function set finalized(b:Boolean) : void {
      }
      
      public function set value(v:Number) : void {
         if(v < 0)
         {
            v = 0;
         }
         if(v > 100)
         {
            v = 100;
         }
         Dofus.getInstance().strProgress = v;
         this._value = v;
         this._progressClip.gotoAndStop(Math.round(v) + 2);
      }
      
      public function get value() : Number {
         return this._value;
      }
      
      public function finalize() : void {
      }
      
      private function finalizeInitialization() : void {
         var logo:Bitmap = null;
         var buildsInfoBig:TextField = null;
         this._logTf = new TextField();
         this._logTf.width = StageShareManager.startWidth;
         this._logTf.height = 500;
         this._logTf.x = 10;
         this._logTf.y = 300;
         var font:String = FontManager.initialized?FontManager.getInstance().getFontClassName("Tahoma"):"Tahoma";
         this._logTf.setTextFormat(new TextFormat(font));
         this._logTf.defaultTextFormat = new TextFormat(font);
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
         if((!this._backgroundBitmap) && (!this._customLoadingScreen))
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
            if((!this._foregroundBitmap) && (!this._customLoadingScreen))
            {
               this._foregroundBitmap = this._foregroundContainer.addChild(new Capabilities.language == "ja"?this._defaultForeground:this._foreground()) as Bitmap;
               this._foregroundBitmap.smoothing = true;
            }
         }
         var bandeauBas:Bitmap = new this._bandeau_bas();
         bandeauBas.y = StageShareManager.startHeight - bandeauBas.height;
         bandeauBas.smoothing = true;
         addChild(bandeauBas);
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
         this._tipsTextField.defaultTextFormat = new TextFormat(font,19,10066329,null,null,null,null,null,"center");
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
               logo = new this._logoJp();
               logo.x = 8;
               logo.y = -30;
               break;
            case "ru":
               logo = new this._logoRu();
               logo.x = 8;
               logo.y = 8;
               break;
         }
         logo.smoothing = true;
         addChild(logo);
         this._progressClip = new this._dofusProgress();
         this._progressClip.x = 608;
         this._progressClip.y = 821;
         this._progressClip.scaleX = this._progressClip.scaleY = 0.5;
         addChild(this._progressClip);
         var buildsInfo:TextField = new TextField();
         buildsInfo.appendText("Dofus " + BuildInfos.BUILD_VERSION + "\n");
         buildsInfo.appendText("Mode " + BuildTypeParser.getTypeName(BuildInfos.BUILD_TYPE) + "\n");
         buildsInfo.appendText(BuildInfos.BUILD_DATE + "\n");
         buildsInfo.appendText("Player " + Capabilities.version);
         buildsInfo.height = 200;
         buildsInfo.width = 300;
         buildsInfo.selectable = false;
         buildsInfo.setTextFormat(new TextFormat(font,null,null,null,null,null,null,null,"right"));
         buildsInfo.textColor = 7829367;
         buildsInfo.y = 5;
         buildsInfo.x = StageShareManager.startWidth - buildsInfo.width;
         addChild(buildsInfo);
         var btnLog:DisplayObject = new this._btnLog();
         btnLog.x = 5;
         btnLog.y = StageShareManager.startHeight - btnLog.height - 5;
         btnLog.addEventListener(MouseEvent.CLICK,this.onLogClick);
         addChild(btnLog);
         this._btnContinueClip = new this._btnContinue() as SimpleButton;
         this._btnContinueClip.x = this._progressClip.x + (this._progressClip.width - this._btnContinueClip.width) / 2;
         this._btnContinueClip.y = this._progressClip.y + this._progressClip.height + 30;
         this._btnContinueClip.addEventListener(MouseEvent.CLICK,this.onContinueClick);
         this._btnContinueClip.visible = false;
         addChild(this._btnContinueClip);
         graphics.beginFill(0);
         graphics.drawRect(0,0,width,height);
         graphics.endFill();
         if((BuildInfos.BUILD_TYPE > BuildTypeEnum.RELEASE) && (this._showBigVersion))
         {
            buildsInfoBig = new TextField();
            buildsInfoBig.appendText(BuildTypeParser.getTypeName(BuildInfos.BUILD_TYPE) + " version");
            buildsInfoBig.x = 300;
            buildsInfoBig.y = 30;
            buildsInfoBig.width = 400;
            buildsInfoBig.selectable = false;
            buildsInfoBig.setTextFormat(new TextFormat(font,30,BuildTypeParser.getTypeColor(BuildInfos.BUILD_TYPE),true));
            addChild(buildsInfoBig);
         }
         iAmFinalized(this);
      }
      
      private function displayAchievmentProgressBar(achievmentsInfo:AchievementListMessage) : void {
         var randomIndex:* = NaN;
         var category:AchievementCategory = null;
         var tempCat:AchievementCategory = null;
         var tempId:uint = 0;
         var font:String = null;
         var achievementsCategories:Array = AchievementCategory.getAchievementCategories();
         var isAParent:Boolean = false;
         while(!isAParent)
         {
            randomIndex = Math.round(Math.random() * (achievementsCategories.length - 1));
            category = achievementsCategories[randomIndex];
            if(category.parentId > 0)
            {
               achievementsCategories.splice(randomIndex,1);
            }
            else
            {
               isAParent = true;
            }
         }
         achievementsCategories = AchievementCategory.getAchievementCategories();
         var finishedAchievement:int = 0;
         var totalAchievement:int = 0;
         for each (tempCat in achievementsCategories)
         {
            if((tempCat.parentId == category.id) || (tempCat.id == category.id))
            {
               for each (tempId in tempCat.achievementIds)
               {
                  if(achievmentsInfo.finishedAchievementsIds.indexOf(tempId) != -1)
                  {
                     finishedAchievement++;
                  }
                  totalAchievement++;
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
         font = FontManager.initialized?FontManager.getInstance().getFontClassName("Tahoma"):"Tahoma";
         this._achievementLabel.x = this._tipsBackgroundBitmap.x;
         this._achievementLabel.defaultTextFormat = new TextFormat(font,19,16777215,null,null,null,null,null,"center");
         this._achievementLabel.embedFonts = true;
         this._achievementLabel.selectable = false;
         this._achievementLabel.visible = true;
         this._achievementLabel.multiline = false;
         this._achievementLabel.text = I18n.getUiText("ui.achievement.achievement") + I18n.getUiText("ui.common.colon") + category.name;
         this._achievementLabel.autoSize = TextFieldAutoSize.LEFT;
         this._achievementNumbersLabel.defaultTextFormat = new TextFormat(font,19,16777215,null,null,null,null,null,"center");
         this._achievementNumbersLabel.embedFonts = true;
         this._achievementNumbersLabel.selectable = false;
         this._achievementNumbersLabel.visible = true;
         this._achievementNumbersLabel.multiline = false;
         this._achievementNumbersLabel.text = finishedAchievement + " / " + totalAchievement;
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
         var colorTransfom:ColorTransform = new ColorTransform();
         colorTransfom.color = uint(category.color);
         this._progressBar.transform.colorTransform = colorTransfom;
         var achievementPercent:Number = finishedAchievement / totalAchievement;
         this._progressBar.width = achievementPercent * this._progressBarBackground.width;
         this._progressBar.visible = true;
         this._progressBarBackground.visible = true;
         addChild(this._progressBarBackground);
         addChild(this._progressBar);
         addChild(this._achievementLabel);
         addChild(this._achievementNumbersLabel);
      }
      
      public function log(text:String, level:uint) : void {
         var tc:ColorTransform = null;
         if((level == ERROR) || (level == WARNING))
         {
            tc = new ColorTransform();
            tc.color = this._levelColor[level];
            this._progressClip.transform.colorTransform = tc;
            this.showLog(true);
         }
         this._logTf.htmlText = "<p><font color=\"#" + uint(this._levelColor[level]).toString(16) + "\">" + text + "</font></p>" + this._logTf.htmlText;
      }
      
      public function showLog(b:Boolean) : void {
         if(this._foregroundBitmap)
         {
            this._foregroundBitmap.visible = !b;
         }
         if(this._backgroundBitmap)
         {
            this._backgroundBitmap.visible = !b;
         }
         this._logTf.visible = b;
      }
      
      public function hideTips() : void {
         this._tipsTextField.visible = false;
         this._tipsBackgroundBitmap.visible = false;
      }
      
      public function set useEmbedFont(b:Boolean) : void {
         this._tipsTextField.embedFonts = false;
      }
      
      public function set tip(txt:String) : void {
         this._tipsTextField.visible = true;
         this._tipsBackgroundBitmap.visible = true;
         this._tipsTextField.htmlText = txt;
      }
      
      public function set continueCallbak(cb:Function) : void {
         this._btnContinueClip.visible = true;
         this.showLog(true);
         this.hideTips();
         this._continueCallBack = cb;
      }
      
      private function onLogClick(e:Event) : void {
         this.showLog(!this._logTf.visible);
      }
      
      private function onContinueClick(e:Event) : void {
         this._continueCallBack();
      }
      
      public function onLoaded(uri:Uri, resourceType:uint, resource:*) : void {
         if(this._customLoadingScreen)
         {
            switch(uri.toString())
            {
               case new Uri(this._customLoadingScreen.backgroundUrl).toString():
                  if(this._backgroundBitmap)
                  {
                     this._backgroundContainer.removeChild(this._backgroundBitmap);
                  }
                  this._backgroundBitmap = new Bitmap(resource as BitmapData);
                  this._backgroundBitmap.smoothing = true;
                  this._backgroundContainer.addChild(this._backgroundBitmap);
                  break;
               case new Uri(this._customLoadingScreen.foregroundUrl).toString():
                  if(this._foregroundBitmap)
                  {
                     this._foregroundContainer.removeChild(this._foregroundBitmap);
                  }
                  this._foregroundBitmap = new Bitmap(resource as BitmapData);
                  this._foregroundBitmap.smoothing = true;
                  this._foregroundContainer.addChild(this._foregroundBitmap);
                  break;
            }
         }
      }
      
      public function onClick(e:MouseEvent) : void {
         if((this._customLoadingScreen) && (this._customLoadingScreen.canBeReadOnScreen(this._beforeLogin)) && (this._customLoadingScreen.linkUrl))
         {
            navigateToURL(new URLRequest(this._customLoadingScreen.linkUrl));
         }
      }
      
      public function onFailed(uri:Uri, errorMsg:String, errorCode:uint) : void {
         _log.error("Failed to load custom loading screen picture (" + uri.toString() + ")");
      }
      
      public function onProgress(uri:Uri, bytesLoaded:uint, bytesTotal:uint) : void {
      }
      
      public function onEnterFrame(e:Event) : void {
         var i:* = 0;
         var workerMessageBuffer:Vector.<Message> = Kernel.getWorker().pausedQueue;
         var connectionMessageBuffer:Array = ConnectionsHandler.getConnection().getPauseBuffer();
         var achievmentsInfo:AchievementListMessage = null;
         if(workerMessageBuffer.length > this._workerbufferSize)
         {
            if(this._workerbufferSize <= 0)
            {
               i = 0;
            }
            else
            {
               i = this._workerbufferSize - 1;
            }
            this._workerbufferSize = workerMessageBuffer.length;
            while(i < this._workerbufferSize)
            {
               if(workerMessageBuffer[i] is AchievementListMessage)
               {
                  achievmentsInfo = workerMessageBuffer[i] as AchievementListMessage;
                  break;
               }
               i++;
            }
         }
         if((!achievmentsInfo) && (connectionMessageBuffer.length > this._connectionBufferSize))
         {
            if(this._connectionBufferSize <= 0)
            {
               i = 0;
            }
            else
            {
               i = this._connectionBufferSize - 1;
            }
            this._connectionBufferSize = connectionMessageBuffer.length;
            while(i < this._connectionBufferSize)
            {
               if(connectionMessageBuffer[i] is AchievementListMessage)
               {
                  achievmentsInfo = connectionMessageBuffer[i] as AchievementListMessage;
                  break;
               }
               i++;
            }
         }
         if(achievmentsInfo)
         {
            EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
            this.displayAchievmentProgressBar(achievmentsInfo);
         }
      }
      
      private function onRemoveFromStage(e:Event) : void {
         EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
      }
   }
}
