package ui
{
   import d2api.TooltipApi;
   import d2api.UiApi;
   import d2api.UtilApi;
   import d2api.DataApi;
   import d2components.GraphicContainer;
   import d2components.Label;
   import d2components.Texture;
   import d2data.Area;
   import d2hooks.*;
   
   public class WorldRpPortalTooltipUi extends Object
   {
      
      public function WorldRpPortalTooltipUi() {
         super();
      }
      
      public var tooltipApi:TooltipApi;
      
      public var uiApi:UiApi;
      
      public var utilApi:UtilApi;
      
      public var dataApi:DataApi;
      
      public var infosCtr:GraphicContainer;
      
      public var lbl_prismName:Label;
      
      public var tx_AllianceEmblemBack:Texture;
      
      public var tx_AllianceEmblemUp:Texture;
      
      public var bgContainer:GraphicContainer;
      
      private var _area:Area;
      
      public function main(oParam:Object = null) : void {
         this._area = this.dataApi.getArea(oParam.data.areaId);
         this.bgContainer.width = 1;
         this.bgContainer.removeFromParent();
         this.lbl_prismName.text = this.uiApi.getText("ui.dimension.portal",this._area.name);
         this.lbl_prismName.fullWidth();
         this.tx_AllianceEmblemBack.uri = null;
         this.tx_AllianceEmblemUp.uri = null;
         this.infosCtr.width = this.lbl_prismName.width + 8;
         this.infosCtr.addContent(this.bgContainer,0);
         this.tooltipApi.place(oParam.position,oParam.point,oParam.relativePoint,oParam.offset);
      }
   }
}
