package com.ankamagames.dofus.misc.options
{
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.managers.CssManager;
   import com.ankamagames.berilia.types.data.ExtendedStyleSheet;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.types.Callback;
   
   public dynamic class ChatOptions extends OptionManager
   {
      
      public function ChatOptions() {
         this.colors = new Array();
         this._cssUri = XmlConfig.getInstance().getEntry("config.ui.skin") + "css/chat.css";
         super("chat");
         add("channelLocked",false);
         add("filterInsult",true);
         add("letLivingObjectTalk",true);
         add("smileysAutoclosed",false);
         add("showTime",false);
         add("showShortcut",false);
         add("showInfoPrefix",false);
         add("chatFontSize",1);
         add("chatExpertMode",true);
         add("channelTabs",[[0,1,2,3,4,7,8,9,10,12,13],[11],[9],[2,5,6]]);
         add("tabsNames",["0","1","2","3"]);
         add("chatoutput",false);
         add("currentChatTheme","");
         CssManager.getInstance().askCss(this._cssUri,new Callback(this.onCssLoaded));
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ChatOptions));
      
      public var colors:Array;
      
      private var _cssUri:String;
      
      private function onCssLoaded() : void {
         var _loc2_:Object = null;
         var _loc1_:ExtendedStyleSheet = CssManager.getInstance().getCss(this._cssUri);
         var _loc3_:String = OptionManager.getOptionManager("dofus").switchUiSkin;
         var _loc4_:String = OptionManager.getOptionManager("chat").currentChatTheme;
         var _loc5_:* = 0;
         while(_loc5_ < 14)
         {
            _loc2_ = _loc1_.getStyle("p" + _loc5_);
            this.colors[_loc5_] = uint(this.color0x(_loc2_["color"]));
            add("channelColor" + _loc5_,this.colors[_loc5_]);
            if(_loc3_ != _loc4_)
            {
               OptionManager.getOptionManager("chat")["channelColor" + _loc5_] = this.colors[_loc5_];
            }
            _loc5_++;
         }
         if(_loc3_ != _loc4_)
         {
            OptionManager.getOptionManager("chat").currentChatTheme = _loc3_;
         }
         _loc2_ = _loc1_.getStyle("p");
         add("alertColor",uint(this.color0x(_loc2_["color"])));
      }
      
      private function color0x(param1:String) : String {
         return param1.replace("#","0x");
      }
   }
}
