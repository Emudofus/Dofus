package ui
{
   import d2api.TooltipApi;
   import d2api.UiApi;
   import d2api.PlayedCharacterApi;
   import d2api.UtilApi;
   import d2api.DataApi;
   import d2components.Label;
   import d2components.GraphicContainer;
   import d2hooks.*;
   
   public class WorldRpPaddockItemTooltipUi extends Object
   {
      
      public function WorldRpPaddockItemTooltipUi() {
         super();
      }
      
      public var tooltipApi:TooltipApi;
      
      public var uiApi:UiApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var utilApi:UtilApi;
      
      public var dataApi:DataApi;
      
      public var lbl_name:Label;
      
      public var lbl_durability:Label;
      
      public var bgCtr:GraphicContainer;
      
      public function main(oParam:Object = null) : void {
         var data:Object = oParam.data;
         this.lbl_name.text = data.name;
         this.lbl_name.fullWidth();
         this.lbl_durability.text = data.durability.durability + "/" + data.durability.durabilityMax;
         this.lbl_durability.fullWidth();
         this.bgCtr.width = this.lbl_name.width > this.lbl_durability.width?this.lbl_name.width + 10:this.lbl_durability.width + 10;
         this.tooltipApi.place(oParam.position,oParam.point,oParam.relativePoint,oParam.offset);
      }
      
      public function unload() : void {
      }
   }
}
