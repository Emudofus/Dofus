package ui
{
   import d2api.SystemApi;
   import d2api.UiApi;
   import d2api.SocialApi;
   import d2api.PlayedCharacterApi;
   import d2components.Label;
   import d2components.Grid;
   import d2enums.GuildInformationsTypeEnum;
   import d2data.TaxCollectorWrapper;
   import d2enums.TaxCollectorStateEnum;
   import d2hooks.*;
   import d2actions.*;
   
   public class GuildTaxCollector extends Object
   {
      
      public function GuildTaxCollector() {
         this._poniesList = new Array();
         super();
      }
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var modCommon:Object;
      
      public var socialApi:SocialApi;
      
      public var playerApi:PlayedCharacterApi;
      
      private var _poniesList:Array;
      
      private var _bDescendingSort:Boolean = false;
      
      public var lbl_ponyCount:Label;
      
      public var gd_pony:Grid;
      
      public function main(... params) : void {
         this.sysApi.addHook(TaxCollectorListUpdate,this.onTaxCollectorListUpdate);
         this.sysApi.addHook(GuildTaxCollectorRemoved,this.onGuildTaxCollectorRemoved);
         this.sysApi.addHook(TaxCollectorError,this.onTaxCollectorError);
         this.sysApi.addHook(TaxCollectorUpdate,this.onTaxCollectorUpdate);
         this.onTaxCollectorListUpdate();
      }
      
      public function unload() : void {
         this.sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_TAX_COLLECTOR_LEAVE));
      }
      
      private function refreshGrid() : void {
         var currentPoniesNumber:uint = this._poniesList.length;
         var maxPoniesNumber:uint = this.socialApi.getMaxCollectorCount();
         this.lbl_ponyCount.text = this.uiApi.getText("ui.social.guild.taxCollectorCount",currentPoniesNumber,maxPoniesNumber);
         this.gd_pony.dataProvider = this._poniesList;
      }
      
      private function onTaxCollectorListUpdate() : void {
         var tc1:TaxCollectorWrapper = null;
         var tc2:TaxCollectorWrapper = null;
         var tc0:TaxCollectorWrapper = null;
         var myrptc:TaxCollectorWrapper = null;
         var rptc:TaxCollectorWrapper = null;
         this._poniesList = new Array();
         var inPeacePonies:Array = new Array();
         var myInPeacePonies:Array = new Array();
         var taxCollectors:Object = this.socialApi.getTaxCollectors();
         var myGuildId:int = this.socialApi.getGuild().guildId;
         for each(tc1 in taxCollectors)
         {
            if((tc1.state == TaxCollectorStateEnum.STATE_WAITING_FOR_HELP) && ((!tc1.guild) || (tc1.guild.guildId == myGuildId)))
            {
               this._poniesList.push(tc1);
            }
         }
         for each(tc2 in taxCollectors)
         {
            if((tc2.state == TaxCollectorStateEnum.STATE_FIGHTING) && ((!tc2.guild) || (tc2.guild.guildId == myGuildId)))
            {
               this._poniesList.push(tc2);
            }
         }
         for each(tc0 in taxCollectors)
         {
            if((tc0.state == TaxCollectorStateEnum.STATE_COLLECTING) && ((!tc0.guild) || (tc0.guild.guildId == myGuildId)))
            {
               if(tc0.additionalInformation.collectorCallerName == this.playerApi.getPlayedCharacterInfo().name)
               {
                  myInPeacePonies.push(tc0);
               }
               else
               {
                  inPeacePonies.push(tc0);
               }
            }
         }
         myInPeacePonies.sortOn("pods",Array.NUMERIC | Array.DESCENDING);
         inPeacePonies.sortOn("pods",Array.NUMERIC | Array.DESCENDING);
         for each(myrptc in myInPeacePonies)
         {
            this._poniesList.push(myrptc);
         }
         for each(rptc in inPeacePonies)
         {
            this._poniesList.push(rptc);
         }
         this.refreshGrid();
      }
      
      private function onGuildTaxCollectorRemoved(tcId:uint) : void {
         this.onTaxCollectorListUpdate();
      }
      
      private function onTaxCollectorUpdate(id:int) : void {
         var tc:TaxCollectorWrapper = null;
         var newTC:TaxCollectorWrapper = null;
         for each(tc in this._poniesList)
         {
            if(tc.uniqueId == id)
            {
               return;
            }
         }
         newTC = this.socialApi.getTaxCollectors()[id];
         if((!newTC.guild) || (newTC.guild.guildId == this.socialApi.getGuild().guildId))
         {
            this._poniesList.push(newTC);
            this.refreshGrid();
         }
      }
      
      private function onTaxCollectorError(error:uint) : void {
         this.sysApi.log(16,"Tax collector error n°" + error);
      }
      
      public function onRelease(target:Object) : void {
      }
   }
}
