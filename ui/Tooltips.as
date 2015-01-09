package 
{
    import flash.display.Sprite;
    import d2api.TooltipApi;
    import d2api.SystemApi;
    import d2api.UiApi;
    import d2api.DataApi;
    import d2api.AlignmentApi;
    import d2api.FightApi;
    import d2api.PlayedCharacterApi;
    import d2api.ChatApi;
    import d2api.AveragePricesApi;
    import d2api.UtilApi;
    import ui.TooltipUi;
    import ui.WorldRpCharacterTooltipUi;
    import ui.TchatTooltipUi;
    import ui.TextInfoTooltipUi;
    import makers.TextTooltipMaker;
    import makers.TextInfoTooltipMaker;
    import makers.TextWithShortcutTooltipMaker;
    import ui.TextWithShortcutTooltipUi;
    import makers.SpellTooltipMaker;
    import ui.SpellTooltipUi;
    import ui.SpellBannerTooltipUi;
    import makers.ItemTooltipMaker;
    import ui.ItemTooltipUi;
    import ui.ItemNameTooltipUi;
    import makers.EffectsTooltipMaker;
    import makers.EffectsListDurationTooltipMaker;
    import ui.EffectsListDurationTooltipUi;
    import makers.SmileyTooltipMaker;
    import makers.TchatTooltipMaker;
    import makers.ThinkTooltipMaker;
    import makers.CraftSmileyTooltipMaker;
    import makers.world.WorldRpCharacterTooltipMaker;
    import makers.world.WorldRpMerchantCharacterTooltipMaker;
    import makers.DelayedActionTooltipMaker;
    import ui.DelayedActionTooltipUi;
    import makers.world.WorldRpMonstersGroupTooltipMaker;
    import ui.WorldRpMonstersGroupTooltipUi;
    import makers.world.WorldRpTaxeCollectorTooltipMaker;
    import ui.WorldRpTaxeCollectorTooltipUi;
    import makers.world.WorldRpPaddockMountTooltipMaker;
    import makers.world.WorldRpPaddockTooltipMaker;
    import ui.WorldRpPaddockTooltipUi;
    import makers.world.WorldRpPaddockItemTooltipMaker;
    import ui.WorldRpPaddockItemTooltipUi;
    import makers.MountTooltipMaker;
    import ui.MountTooltipUi;
    import makers.world.WorldTaxeCollectorFighterTooltipMaker;
    import makers.ChallengeTooltipMaker;
    import makers.world.WorldPlayerFighterTooltipMaker;
    import ui.WorldCharacterFighterTooltipUi;
    import makers.world.WorldMonsterFighterTooltipMaker;
    import ui.WorldMonsterFighterTooltipUi;
    import makers.world.WorldCompanionFighterTooltipMaker;
    import ui.WorldCompanionFighterTooltipUi;
    import makers.world.WorldRpFightTooltipMaker;
    import ui.WorldRpFightTooltipUi;
    import makers.world.WorldRpGroundObjectTooltipMaker;
    import makers.world.WorldRpPrismTooltipMaker;
    import ui.WorldRpPrismTooltipUi;
    import ui.WorldRpPortalTooltipUi;
    import makers.EffectsListTooltipMaker;
    import makers.TexturesListTooltipMaker;
    import makers.world.WorldRpHouseTooltipMaker;
    import ui.HouseTooltipUi;
    import makers.SellCriterionTooltipMaker;
    import makers.world.WorldRpInteractiveElementTooltipMaker;
    import ui.InteractiveElementTooltipUi;
    import d2hooks.*;

    public class Tooltips extends Sprite 
    {

        public static var STATS_ICONS_PATH:String;

        public var tooltipApi:TooltipApi;
        public var sysApi:SystemApi;
        public var uiApi:UiApi;
        public var dataApi:DataApi;
        public var alignApi:AlignmentApi;
        public var fightApi:FightApi;
        public var playerApi:PlayedCharacterApi;
        public var chatApi:ChatApi;
        public var averagePricesApi:AveragePricesApi;
        public var utilApi:UtilApi;
        private var include_TooltipUi:TooltipUi = null;
        private var include_WorldRpCharacterTooltipUi:WorldRpCharacterTooltipUi = null;
        private var include_TchatTooltipUi:TchatTooltipUi = null;
        private var include_TextInfoTooltipUi:TextInfoTooltipUi = null;


        public function main():void
        {
            Api.system = this.sysApi;
            Api.ui = this.uiApi;
            Api.tooltip = this.tooltipApi;
            Api.data = this.dataApi;
            Api.alignment = this.alignApi;
            Api.fight = this.fightApi;
            Api.player = this.playerApi;
            Api.chat = this.chatApi;
            Api.averagePrices = this.averagePricesApi;
            Api.util = this.utilApi;
            this.uiApi.preloadCss((this.sysApi.getConfigEntry("config.ui.skin") + "css/tooltip_npc.css"));
            this.tooltipApi.setDefaultTooltipUiScript("Ankama_Tooltips", "tooltip");
            this.tooltipApi.registerTooltipMaker("text", TextTooltipMaker);
            this.tooltipApi.registerTooltipMaker("textInfo", TextInfoTooltipMaker, TextInfoTooltipUi);
            this.tooltipApi.registerTooltipMaker("textWithShortcut", TextWithShortcutTooltipMaker, TextWithShortcutTooltipUi);
            this.tooltipApi.registerTooltipMaker("spell", SpellTooltipMaker, SpellTooltipUi);
            this.tooltipApi.registerTooltipMaker("spellBanner", TextInfoTooltipMaker, SpellBannerTooltipUi);
            this.tooltipApi.registerTooltipMaker("item", ItemTooltipMaker, ItemTooltipUi);
            this.tooltipApi.registerTooltipMaker("itemName", TextInfoTooltipMaker, ItemNameTooltipUi);
            this.tooltipApi.registerTooltipMaker("effects", EffectsTooltipMaker);
            this.tooltipApi.registerTooltipMaker("effectsDuration", EffectsListDurationTooltipMaker, EffectsListDurationTooltipUi);
            this.tooltipApi.registerTooltipMaker("smiley", SmileyTooltipMaker);
            this.tooltipApi.registerTooltipMaker("chatBubble", TchatTooltipMaker, TchatTooltipUi);
            this.tooltipApi.registerTooltipMaker("thinkBubble", ThinkTooltipMaker, TchatTooltipUi);
            this.tooltipApi.registerTooltipMaker("craftSmiley", CraftSmileyTooltipMaker);
            this.tooltipApi.registerTooltipMaker("player", WorldRpCharacterTooltipMaker, WorldRpCharacterTooltipUi);
            this.tooltipApi.registerTooltipMaker("mutant", WorldRpCharacterTooltipMaker, WorldRpCharacterTooltipUi);
            this.tooltipApi.registerTooltipMaker("merchant", WorldRpMerchantCharacterTooltipMaker, WorldRpCharacterTooltipUi);
            this.tooltipApi.registerTooltipMaker("delayedAction", DelayedActionTooltipMaker, DelayedActionTooltipUi);
            this.tooltipApi.registerTooltipMaker("monsterGroup", WorldRpMonstersGroupTooltipMaker, WorldRpMonstersGroupTooltipUi);
            this.tooltipApi.registerTooltipMaker("taxCollector", WorldRpTaxeCollectorTooltipMaker, WorldRpTaxeCollectorTooltipUi);
            this.tooltipApi.registerTooltipMaker("paddockMount", WorldRpPaddockMountTooltipMaker);
            this.tooltipApi.registerTooltipMaker("paddock", WorldRpPaddockTooltipMaker, WorldRpPaddockTooltipUi);
            this.tooltipApi.registerTooltipMaker("paddockItem", WorldRpPaddockItemTooltipMaker, WorldRpPaddockItemTooltipUi);
            this.tooltipApi.registerTooltipMaker("mount", MountTooltipMaker, MountTooltipUi);
            this.tooltipApi.registerTooltipMaker("fightTaxCollector", WorldTaxeCollectorFighterTooltipMaker);
            this.tooltipApi.registerTooltipMaker("challenge", ChallengeTooltipMaker);
            this.tooltipApi.registerTooltipMaker("playerFighter", WorldPlayerFighterTooltipMaker, WorldCharacterFighterTooltipUi);
            this.tooltipApi.registerTooltipMaker("monsterFighter", WorldMonsterFighterTooltipMaker, WorldMonsterFighterTooltipUi);
            this.tooltipApi.registerTooltipMaker("companionFighter", WorldCompanionFighterTooltipMaker, WorldCompanionFighterTooltipUi);
            this.tooltipApi.registerTooltipMaker("roleplayFight", WorldRpFightTooltipMaker, WorldRpFightTooltipUi);
            this.tooltipApi.registerTooltipMaker("groundObject", WorldRpGroundObjectTooltipMaker);
            this.tooltipApi.registerTooltipMaker("prism", WorldRpPrismTooltipMaker, WorldRpPrismTooltipUi);
            this.tooltipApi.registerTooltipMaker("portal", WorldRpPrismTooltipMaker, WorldRpPortalTooltipUi);
            this.tooltipApi.registerTooltipMaker("effectsList", EffectsListTooltipMaker);
            this.tooltipApi.registerTooltipMaker("texturesList", TexturesListTooltipMaker);
            this.tooltipApi.registerTooltipMaker("house", WorldRpHouseTooltipMaker, HouseTooltipUi);
            this.tooltipApi.registerTooltipMaker("sellCriterion", SellCriterionTooltipMaker);
            this.tooltipApi.registerTooltipMaker("interactiveElement", WorldRpInteractiveElementTooltipMaker, InteractiveElementTooltipUi);
            STATS_ICONS_PATH = this.sysApi.getConfigKey("content.path").concat("gfx/characteristics/characteristics.swf|tx_");
        }

        public function unload():void
        {
            Api.system = null;
            Api.ui = null;
            Api.tooltip = null;
            Api.data = null;
            Api.alignment = null;
            Api.fight = null;
            Api.player = null;
            Api.chat = null;
            Api.averagePrices = null;
            Api.util = null;
        }


    }
}//package 

