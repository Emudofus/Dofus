package ui
{
   import d2api.SystemApi;
   import d2api.TooltipApi;
   import d2hooks.*;
   
   public class TextWithShortcutTooltipUi extends Object
   {
      
      public function TextWithShortcutTooltipUi() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var tooltipApi:TooltipApi;
      
      public var mainCtr:Object;
      
      public var lbl_text:Object;
      
      public function main(oParam:Object = null) : void {
         this.lbl_text.useCustomFormat = true;
         var shortcut:* = oParam.data.shortcut;
         if((shortcut.indexOf("(") == 0) && (shortcut.indexOf(")") == shortcut.length - 1))
         {
            shortcut = shortcut.substr(1,shortcut.length - 2);
         }
         var shortcutColor:String = this.sysApi.getConfigEntry("colors.shortcut");
         shortcutColor = shortcutColor.replace("0x","#");
         this.lbl_text.text = oParam.data.text + " <font color=\'" + shortcutColor + "\'>(" + shortcut + ")</font>";
         this.tooltipApi.place(oParam.position,oParam.point,oParam.relativePoint,oParam.offset);
      }
   }
}
