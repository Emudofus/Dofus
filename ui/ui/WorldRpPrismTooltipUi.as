package ui
{
   import d2api.TooltipApi;
   import d2api.UiApi;
   import d2api.UtilApi;
   import d2api.DataApi;
   import d2components.GraphicContainer;
   import d2components.Label;
   import d2components.Texture;
   import d2data.AllianceWrapper;
   import d2hooks.*;
   import d2enums.EventEnums;
   import d2data.EmblemSymbol;
   
   public class WorldRpPrismTooltipUi extends Object
   {
      
      public function WorldRpPrismTooltipUi() {
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
      
      private var _alliance:AllianceWrapper;
      
      public function main(oParam:Object = null) : void {
         this._alliance = oParam.data.allianceIdentity;
         this.bgContainer.width = 1;
         this.bgContainer.removeFromParent();
         this.lbl_prismName.text = this._alliance.allianceName;
         this.lbl_prismName.fullWidth();
         this.lbl_prismName.y = this.tx_AllianceEmblemBack.height / 2 - this.lbl_prismName.height / 2;
         this.tx_AllianceEmblemBack.x = this.lbl_prismName.width + 8;
         this.tx_AllianceEmblemUp.x = this.tx_AllianceEmblemBack.x + 8;
         this.tx_AllianceEmblemUp.y = this.tx_AllianceEmblemBack.y + 8;
         this.tx_AllianceEmblemBack.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_AllianceEmblemBack,EventEnums.EVENT_ONTEXTUREREADY);
         this.tx_AllianceEmblemBack.uri = this.uiApi.createUri(this.uiApi.me().getConstant("emblems") + "backalliance/" + this._alliance.backEmblem.idEmblem + ".swf");
         this.tx_AllianceEmblemUp.dispatchMessages = true;
         this.uiApi.addComponentHook(this.tx_AllianceEmblemUp,EventEnums.EVENT_ONTEXTUREREADY);
         this.tx_AllianceEmblemUp.uri = this._alliance.upEmblem.fullSizeIconUri;
         this.infosCtr.width = this.lbl_prismName.width + 8 + this.tx_AllianceEmblemBack.width;
         this.infosCtr.height = this.tx_AllianceEmblemBack.height;
         this.infosCtr.addContent(this.bgContainer,0);
         this.tooltipApi.place(oParam.position,oParam.point,oParam.relativePoint,oParam.offset);
      }
      
      public function onTextureReady(pTarget:Object) : void {
         var icon:EmblemSymbol = null;
         if(pTarget == this.tx_AllianceEmblemBack)
         {
            this.utilApi.changeColor(this.tx_AllianceEmblemBack.getChildByName("back"),this._alliance.backEmblem.color,1);
            this.tx_AllianceEmblemBack.visible = true;
         }
         else if(pTarget == this.tx_AllianceEmblemUp)
         {
            icon = this.dataApi.getEmblemSymbol(this._alliance.upEmblem.idEmblem);
            if(icon.colorizable)
            {
               this.utilApi.changeColor(this.tx_AllianceEmblemUp.getChildByName("up"),this._alliance.upEmblem.color,0);
            }
            else
            {
               this.utilApi.changeColor(this.tx_AllianceEmblemUp.getChildByName("up"),this._alliance.upEmblem.color,0,true);
            }
            this.tx_AllianceEmblemUp.visible = true;
         }
         
      }
   }
}
