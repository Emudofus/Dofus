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
         var styleObj:Object = null;
         var _ssSheet:ExtendedStyleSheet = CssManager.getInstance().getCss(this._cssUri);
         var theme:String = OptionManager.getOptionManager("dofus").switchUiSkin;
         var chatTheme:String = OptionManager.getOptionManager("chat").currentChatTheme;
         var i:int = 0;
         while(i < 14)
         {
            styleObj = _ssSheet.getStyle("p" + i);
            this.colors[i] = uint(this.color0x(styleObj["color"]));
            add("channelColor" + i,this.colors[i]);
            if(theme != chatTheme)
            {
               OptionManager.getOptionManager("chat")["channelColor" + i] = this.colors[i];
            }
            i++;
         }
         if(theme != chatTheme)
         {
            OptionManager.getOptionManager("chat").currentChatTheme = theme;
         }
         styleObj = _ssSheet.getStyle("p");
         add("alertColor",uint(this.color0x(styleObj["color"])));
      }
      
      private function color0x(color:String) : String {
         return color.replace("#","0x");
      }
   }
}
