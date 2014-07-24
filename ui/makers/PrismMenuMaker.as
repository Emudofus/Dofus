package makers
{
   import d2actions.*;
   import d2hooks.*;
   import d2network.AlliancePrismInformation;
   import d2network.AllianceInsiderPrismInformation;
   import d2data.AllianceWrapper;
   import d2network.PrismInformation;
   import d2enums.PrismStateEnum;
   
   public class PrismMenuMaker extends Object
   {
      
      public function PrismMenuMaker() {
         super();
      }
      
      public static var disabled:Boolean = false;
      
      public var _subAreaId:int;
      
      private function onPrismTalk(entityId:int) : void {
         Api.system.sendAction(new NpcGenericActionRequest(entityId,3));
      }
      
      private function onPrismAttacked() : void {
         Api.system.sendAction(new PrismAttackRequest());
      }
      
      private function onPrismTeleport() : void {
         Api.system.sendAction(new PrismUseRequest());
      }
      
      private function onPrismModify() : void {
         var subAreaId:int = Api.player.currentSubArea().id;
         Api.system.dispatchHook(OpenSocial,2,1,[subAreaId]);
      }
      
      private function onPrismSabotage(nextVulneDate:Number) : void {
         this._subAreaId = Api.player.currentSubArea().id;
         var vulneStart:String = Api.time.getDate(nextVulneDate * 1000) + " " + Api.time.getClock(nextVulneDate * 1000);
         Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"),Api.ui.getText("ui.prism.sabotageConfirm",Api.player.currentSubArea().name,vulneStart),[Api.ui.getText("ui.common.yes"),Api.ui.getText("ui.common.no")],[this.onValidSabotage],this.onValidSabotage);
      }
      
      protected function onValidSabotage() : void {
         Api.system.sendAction(new PrismSetSabotagedRequest(this._subAreaId));
      }
      
      public function createMenu(data:*, param:Object) : Array {
         var name:String = null;
         var alPrismInfos:AlliancePrismInformation = null;
         var allianceName:String = null;
         var allianceTag:String = null;
         var tag:String = null;
         var alInsiderPrismInfos:AllianceInsiderPrismInformation = null;
         var myAllianceInfos:AllianceWrapper = null;
         var menu:Array = new Array();
         var dead:Boolean = !Api.player.isAlive();
         var prismInfos:PrismInformation = data.prism;
         if(prismInfos is AlliancePrismInformation)
         {
            alPrismInfos = prismInfos as AlliancePrismInformation;
            allianceName = alPrismInfos.alliance.allianceName;
            if(allianceName == "#NONAME#")
            {
               allianceName = Api.ui.getText("ui.guild.noName");
            }
            allianceTag = alPrismInfos.alliance.allianceTag;
            if(allianceTag == "#TAG#")
            {
               allianceTag = Api.ui.getText("ui.alliance.noTag");
            }
            tag = " \\[" + allianceTag + "]";
            name = allianceName + tag;
            menu.push(ContextMenu.static_createContextMenuTitleObject(name));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.talk"),this.onPrismTalk,[param[0].id]));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.attack"),this.onPrismAttacked,null,(disabled) || (dead) || (!(prismInfos.state == PrismStateEnum.PRISM_STATE_NORMAL))));
         }
         else if(prismInfos is AllianceInsiderPrismInformation)
         {
            alInsiderPrismInfos = prismInfos as AllianceInsiderPrismInformation;
            myAllianceInfos = Api.social.getAlliance();
            name = myAllianceInfos.allianceName + " \\[" + myAllianceInfos.allianceTag + "]";
            trace(name);
            menu.push(ContextMenu.static_createContextMenuTitleObject(name));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.talk"),this.onPrismTalk,[param[0].id]));
            if(alInsiderPrismInfos.hasTeleporterModule)
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.teleport"),this.onPrismTeleport,null,false));
            }
            if(Api.social.hasGuildRight(Api.player.id(),"setAlliancePrism"))
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.modify"),this.onPrismModify));
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.prism.sabotage"),this.onPrismSabotage,[alInsiderPrismInfos.nextVulnerabilityDate],!(prismInfos.state == PrismStateEnum.PRISM_STATE_NORMAL)));
            }
         }
         
         return menu;
      }
   }
}
