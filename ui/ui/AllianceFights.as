package ui
{
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.SocialApi;
    import d2components.Grid;
    import d2components.Label;
    import d2components.ButtonContainer;
    import d2data.SocialEntityInFightWrapper;
    import d2hooks.TaxCollectorListUpdate;
    import d2hooks.TaxCollectorUpdate;
    import d2hooks.AllianceTaxCollectorRemoved;
    import d2hooks.PrismsInFightList;
    import d2hooks.PrismInFightAdded;
    import d2hooks.PrismInFightRemoved;
    import d2actions.GuildGetInformations;
    import d2enums.GuildInformationsTypeEnum;
    import d2hooks.*;
    import d2actions.*;

    public class AllianceFights 
    {

        private static const TYPE_TAX_COLLECTOR:int = 0;
        private static const TYPE_PRISM:int = 1;
        private static var _self:AllianceFights;

        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var socialApi:SocialApi;
        private var _fightsList:Array;
        private var _forceShowType:int = -1;
        private var _forceShowFight:int = -1;
        private var _bDescendingSort:Boolean = false;
        public var gd_fights:Grid;
        public var lbl_fightsCount:Label;
        public var btn_tabName:ButtonContainer;
        public var btn_tabState:ButtonContainer;

        public function AllianceFights()
        {
            this._fightsList = new Array();
            super();
        }

        public static function getInstance():AllianceFights
        {
            return (_self);
        }


        public function main(... args):void
        {
            var fight:SocialEntityInFightWrapper;
            _self = this;
            this.sysApi.addHook(TaxCollectorListUpdate, this.onTaxCollectorsListUpdate);
            this.sysApi.addHook(TaxCollectorUpdate, this.onTaxCollectorUpdate);
            this.sysApi.addHook(AllianceTaxCollectorRemoved, this.onAllianceTaxCollectorRemoved);
            this.sysApi.addHook(PrismsInFightList, this.onPrismsInFightList);
            this.sysApi.addHook(PrismInFightAdded, this.onPrismInFightAdded);
            this.sysApi.addHook(PrismInFightRemoved, this.onPrismInFightRemoved);
            this.sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_TAX_COLLECTOR_ALLIANCE));
            if (((args) && (args[0])))
            {
                this._forceShowType = args[0][0];
                this._forceShowFight = args[0][1];
            }
            else
            {
                this._forceShowType = -1;
                this._forceShowFight = -1;
            };
            for each (fight in this.socialApi.getAllFightingTaxCollectors())
            {
                this._fightsList.push(fight);
            };
            for each (fight in this.socialApi.getFightingPrisms())
            {
                this._fightsList.push(fight);
            };
            this.refreshGrid();
        }

        public function unload():void
        {
            this.sysApi.sendAction(new GuildGetInformations(GuildInformationsTypeEnum.INFO_TAX_COLLECTOR_LEAVE));
        }

        public function get forceShowType():int
        {
            return (this._forceShowType);
        }

        public function get forceShowFight():int
        {
            return (this._forceShowFight);
        }

        private function refreshGrid():void
        {
            var currentFightsNumber:uint = this._fightsList.length;
            this.lbl_fightsCount.text = this.uiApi.processText(this.uiApi.getText("ui.alliance.currentFights", currentFightsNumber), "m", (currentFightsNumber < 2));
            this._fightsList.sortOn("fightTime", (Array.NUMERIC | Array.DESCENDING));
            this.gd_fights.dataProvider = this._fightsList;
            var i:int;
            while (i < this._fightsList.length)
            {
                if ((((this._forceShowType == this._fightsList[i].typeId)) && ((this._forceShowFight == this._fightsList[i].uniqueId))))
                {
                    this.gd_fights.moveTo(i, true);
                    return;
                };
                i++;
            };
        }

        private function onTaxCollectorsListUpdate():void
        {
            var fight:SocialEntityInFightWrapper;
            var newList:Array = new Array();
            for each (fight in this._fightsList)
            {
                if (fight.typeId != TYPE_TAX_COLLECTOR)
                {
                    newList.push(fight);
                };
            };
            this._fightsList = newList;
            for each (fight in this.socialApi.getAllFightingTaxCollectors())
            {
                this._fightsList.push(fight);
            };
            this.refreshGrid();
        }

        private function onTaxCollectorUpdate(id:int):void
        {
            var fight:SocialEntityInFightWrapper;
            var tc:SocialEntityInFightWrapper = this.socialApi.getAllFightingTaxCollector(id);
            var index:int = -1;
            for each (fight in this._fightsList)
            {
                if ((((fight.uniqueId == id)) && ((fight.typeId == TYPE_TAX_COLLECTOR))))
                {
                    index = this._fightsList.indexOf(fight);
                };
            };
            if ((((index > -1)) && (!(tc))))
            {
                this._fightsList.splice(index, 1);
            }
            else
            {
                if ((((index == -1)) && (tc)))
                {
                    this._fightsList.push(tc);
                };
            };
            this.refreshGrid();
        }

        private function onAllianceTaxCollectorRemoved(uniqueId:int):void
        {
            var fight:SocialEntityInFightWrapper;
            var index:int = -1;
            for each (fight in this._fightsList)
            {
                if ((((fight.uniqueId == uniqueId)) && ((fight.typeId == TYPE_TAX_COLLECTOR))))
                {
                    index = this._fightsList.indexOf(fight);
                };
            };
            if (index > -1)
            {
                this._fightsList.splice(index, 1);
            };
            this.refreshGrid();
        }

        private function onPrismsInFightList():void
        {
            var fight:SocialEntityInFightWrapper;
            var newList:Array = new Array();
            for each (fight in this._fightsList)
            {
                if (fight.typeId != TYPE_PRISM)
                {
                    newList.push(fight);
                };
            };
            this._fightsList = newList;
            for each (fight in this.socialApi.getFightingPrisms())
            {
                this._fightsList.push(fight);
            };
            this.refreshGrid();
        }

        private function onPrismInFightAdded(subAreaId:int):void
        {
            var p:SocialEntityInFightWrapper = this.socialApi.getFightingPrism(subAreaId);
            this._fightsList.push(p);
            this.refreshGrid();
        }

        private function onPrismInFightRemoved(subAreaId:int):void
        {
            var fight:SocialEntityInFightWrapper;
            var index:int = -1;
            for each (fight in this._fightsList)
            {
                if ((((fight.uniqueId == subAreaId)) && ((fight.typeId == TYPE_PRISM))))
                {
                    index = this._fightsList.indexOf(fight);
                };
            };
            if (index > -1)
            {
                this._fightsList.splice(index, 1);
            };
            this.refreshGrid();
        }


    }
}//package ui

