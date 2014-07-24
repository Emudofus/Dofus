package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.UtilApi;
   import d2api.SocialApi;
   import d2api.DataApi;
   import d2api.TimeApi;
   import d2api.ChatApi;
   import d2components.GraphicContainer;
   import d2components.Label;
   import d2components.Texture;
   import d2components.ButtonContainer;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import d2enums.ComponentHookList;
   import d2enums.PrismListenEnum;
   import d2hooks.*;
   import d2actions.*;
   import d2data.EmblemSymbol;
   
   public class Alliance extends Object
   {
      
      public function Alliance() {
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var utilApi:UtilApi;
      
      public var modCommon:Object;
      
      public var socialApi:SocialApi;
      
      public var dataApi:DataApi;
      
      public var timeApi:TimeApi;
      
      public var chatApi:ChatApi;
      
      private var _nCurrentTab:int = -1;
      
      private var _alliance:Object;
      
      public var mainCtr:GraphicContainer;
      
      public var lbl_title:Label;
      
      public var lbl_tag:Label;
      
      public var lbl_creationDate:Label;
      
      public var lbl_members:Label;
      
      public var tx_emblemBack:Texture;
      
      public var tx_emblemUp:Texture;
      
      public var tx_disabled:Texture;
      
      public var btn_members:ButtonContainer;
      
      public var btn_areas:ButtonContainer;
      
      public var btn_fights:ButtonContainer;
      
      public function main(... args) : void {
         this.btn_members.soundId = SoundEnum.TAB;
         this.btn_areas.soundId = SoundEnum.TAB;
         this.btn_fights.soundId = SoundEnum.TAB;
         this.sysApi.addHook(AllianceUpdateInformations,this.onAllianceUpdateInformations);
         this.uiApi.addComponentHook(this.btn_members,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_areas,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_fights,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_disabled,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_disabled,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_emblemBack,ComponentHookList.ON_TEXTURE_READY);
         this.uiApi.addComponentHook(this.tx_emblemUp,ComponentHookList.ON_TEXTURE_READY);
         this.tx_emblemBack.dispatchMessages = true;
         this.tx_emblemUp.dispatchMessages = true;
         this.sysApi.sendAction(new PrismsListRegister("Alliance",PrismListenEnum.PRISM_LISTEN_MINE));
         this._alliance = this.socialApi.getAlliance();
         this.updateAllianceInfos();
         this.openSelectedTab(args[0][0],args[0][1]);
      }
      
      public function unload() : void {
         this.sysApi.sendAction(new PrismsListRegister("Alliance",PrismListenEnum.PRISM_LISTEN_NONE));
         this.uiApi.unloadUi("subAllianceUi");
      }
      
      private function updateAllianceInfos() : void {
         this.lbl_title.text = this.uiApi.getText("ui.common.alliance") + " - " + this._alliance.allianceName;
         this.lbl_tag.text = this.chatApi.getAllianceLink(this._alliance,"[" + this._alliance.allianceTag + "]");
         this.lbl_creationDate.text = this.timeApi.getDofusDate(this._alliance.creationDate * 1000);
         this.lbl_members.text = this.uiApi.processText(this.uiApi.getText("ui.alliance.membersInGuilds",this._alliance.nbMembers,this._alliance.nbGuilds),"n",this._alliance.nbGuilds < 2);
         if(this._alliance.enabled)
         {
            this.tx_disabled.visible = false;
         }
         else
         {
            this.tx_disabled.visible = true;
         }
         this.tx_emblemBack.uri = this.uiApi.createUri(this.uiApi.me().getConstant("picto_uri") + "backalliance/" + this._alliance.backEmblem.idEmblem + ".swf");
         this.tx_emblemUp.uri = this.uiApi.createUri(this.uiApi.me().getConstant("picto_uri") + "up/" + this._alliance.upEmblem.idEmblem + ".swf");
      }
      
      private function openSelectedTab(tab:uint, params:Object = null) : void {
         if(this._nCurrentTab == tab)
         {
            return;
         }
         this.uiApi.unloadUi("subAllianceUi");
         this.uiApi.loadUiInside(this.getUiNameByTab(tab),this.mainCtr,"subAllianceUi",params);
         this.getButtonByTab(tab).selected = true;
      }
      
      private function getUiNameByTab(tab:uint) : String {
         if(tab == 0)
         {
            return "allianceMembers";
         }
         if(tab == 1)
         {
            return "allianceAreas";
         }
         if(tab == 2)
         {
            return "allianceFights";
         }
         return null;
      }
      
      private function getButtonByTab(tab:uint) : Object {
         if(tab == 0)
         {
            return this.btn_members;
         }
         if(tab == 1)
         {
            return this.btn_areas;
         }
         if(tab == 2)
         {
            return this.btn_fights;
         }
         return null;
      }
      
      public function onTextureReady(target:Object) : void {
         var icon:EmblemSymbol = null;
         switch(target)
         {
            case this.tx_emblemBack:
               this.utilApi.changeColor(this.tx_emblemBack.getChildByName("back"),this._alliance.backEmblem.color,1);
               break;
            case this.tx_emblemUp:
               icon = this.dataApi.getEmblemSymbol(this._alliance.upEmblem.idEmblem);
               if(icon.colorizable)
               {
                  this.utilApi.changeColor(this.tx_emblemUp.getChildByName("up"),this._alliance.upEmblem.color,0);
               }
               else
               {
                  this.utilApi.changeColor(this.tx_emblemUp.getChildByName("up"),this._alliance.upEmblem.color,0,true);
               }
               break;
         }
      }
      
      private function onAllianceUpdateInformations() : void {
         this._alliance = this.socialApi.getAlliance();
         this.updateAllianceInfos();
      }
      
      public function onRelease(target:Object) : void {
         if(target == this.btn_members)
         {
            this.openSelectedTab(0);
         }
         else if(target == this.btn_areas)
         {
            this.openSelectedTab(1);
         }
         else if(target == this.btn_fights)
         {
            this.openSelectedTab(2);
         }
         
         
      }
      
      public function onRollOver(target:Object) : void {
         var tooltipText:String = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         switch(target)
         {
            case this.tx_disabled:
               tooltipText = this.uiApi.getText("ui.alliance.disabled");
               break;
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:Object) : void {
         this.uiApi.hideTooltip();
      }
   }
}
