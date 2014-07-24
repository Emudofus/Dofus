package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2components.ButtonContainer;
   
   public class Zoom extends Object
   {
      
      public function Zoom() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      private var _currentZoom:Number;
      
      public var btnCancel:ButtonContainer;
      
      public var btnZoom1:ButtonContainer;
      
      public var btnZoom2:ButtonContainer;
      
      public var btnZoom3:ButtonContainer;
      
      public var btnZoom4:ButtonContainer;
      
      public var btnZoom5:ButtonContainer;
      
      public function main(param:Object) : void {
         this.uiApi.addComponentHook(this.btnCancel,"onRelease");
         this.uiApi.addComponentHook(this.btnCancel,"onRollOver");
         this.uiApi.addComponentHook(this.btnCancel,"onRollOut");
         this.uiApi.addComponentHook(this.btnZoom1,"onRelease");
         this.uiApi.addComponentHook(this.btnZoom2,"onRelease");
         this.uiApi.addComponentHook(this.btnZoom3,"onRelease");
         this.uiApi.addComponentHook(this.btnZoom4,"onRelease");
         this.uiApi.addComponentHook(this.btnZoom5,"onRelease");
         this.sysApi.zoom(2);
         this.btnZoom3.selected = true;
      }
      
      public function unload() : void {
         this.uiApi.hideTooltip();
      }
      
      public function onRollOver(target:Object) : void {
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.common.cancelZoom")),target,false,"standard",1,7,10,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
      
      public function onRelease(target:Object) : void {
         if(target == this.btnCancel)
         {
            this.sysApi.zoom(1);
            this.uiApi.unloadUi("zoomUi");
         }
         else if(target == this.btnZoom1)
         {
            this.sysApi.zoom(1);
         }
         else if(target == this.btnZoom2)
         {
            this.sysApi.zoom(1.5);
         }
         else if(target == this.btnZoom3)
         {
            this.sysApi.zoom(2);
         }
         else if(target == this.btnZoom4)
         {
            this.sysApi.zoom(3);
         }
         else if(target == this.btnZoom5)
         {
            this.sysApi.zoom(4);
         }
         
         
         
         
         
      }
   }
}
