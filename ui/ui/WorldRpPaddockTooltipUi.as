package ui
{
    import d2api.TooltipApi;
    import d2api.UiApi;
    import d2api.PlayedCharacterApi;
    import d2api.UtilApi;
    import d2api.DataApi;
    import d2components.Texture;
    import d2components.Label;
    import d2data.GuildWrapper;
    import d2data.EmblemSymbol;
    import d2hooks.*;

    public class WorldRpPaddockTooltipUi 
    {

        public var tooltipApi:TooltipApi;
        public var uiApi:UiApi;
        public var playerApi:PlayedCharacterApi;
        public var utilApi:UtilApi;
        public var dataApi:DataApi;
        public var tx_emblemBack:Texture;
        public var tx_emblemUp:Texture;
        public var lbl_paddockSize:Label;
        public var lbl_price:Label;
        public var lbl_type:Label;
        private var _guild:GuildWrapper;


        public function main(oParam:Object=null):void
        {
            var hasGuild:Boolean = oParam.data.hasOwnProperty("guildIdentity");
            if (((hasGuild) && (oParam.data.guildIdentity)))
            {
                this._guild = oParam.data.guildIdentity;
                this.tx_emblemBack.visible = false;
                this.tx_emblemBack.dispatchMessages = true;
                this.uiApi.addComponentHook(this.tx_emblemBack, "onTextureReady");
                this.tx_emblemBack.uri = this._guild.backEmblem.fullSizeIconUri;
                this.tx_emblemUp.visible = true;
                this.tx_emblemUp.dispatchMessages = true;
                this.uiApi.addComponentHook(this.tx_emblemUp, "onTextureReady");
                this.tx_emblemUp.uri = this._guild.upEmblem.fullSizeIconUri;
            };
            if (((oParam.data.hasOwnProperty("price")) && (oParam.data.price)))
            {
                if (!(oParam.data.isSaleLocked))
                {
                    this.lbl_type.text = this.uiApi.getText("ui.mount.paddockToBuy", this.utilApi.kamasToString(oParam.data.price));
                }
                else
                {
                    this.lbl_type.text = this.uiApi.getText("ui.mount.paddockToBuySoon", this.utilApi.kamasToString(oParam.data.price));
                };
                this.lbl_paddockSize.text = this.uiApi.getText("ui.mount.paddockSize", oParam.data.maxItems, oParam.data.maxOutdoorMount);
            }
            else
            {
                if (((hasGuild) && (this._guild)))
                {
                    this.lbl_type.text = this.uiApi.getText("ui.mount.paddockPrivate");
                    this.lbl_paddockSize.text = this.uiApi.getText("ui.mount.paddockSize", oParam.data.maxItems, oParam.data.maxOutdoorMount);
                }
                else
                {
                    if (((oParam.data.hasOwnProperty("isAbandonned")) && (oParam.data.isAbandonned)))
                    {
                        this.lbl_type.text = this.uiApi.getText("ui.mount.paddockAbandonned");
                        this.lbl_paddockSize.text = this.uiApi.getText("ui.mount.maxMount", oParam.data.maxItems);
                    }
                    else
                    {
                        this.lbl_type.text = this.uiApi.getText("ui.mount.paddockPublic");
                        this.lbl_paddockSize.text = this.uiApi.getText("ui.mount.maxMount", oParam.data.maxItems);
                    };
                };
            };
            this.tooltipApi.place(oParam.position, oParam.point, oParam.relativePoint, oParam.offset);
        }

        public function onTextureReady(target:Object):void
        {
            var _local_2:EmblemSymbol;
            switch (target)
            {
                case this.tx_emblemBack:
                    this.utilApi.changeColor(this.tx_emblemBack.getChildByName("back"), this._guild.backEmblem.color, 1);
                    this.tx_emblemBack.visible = true;
                    break;
                case this.tx_emblemUp:
                    _local_2 = this.dataApi.getEmblemSymbol(this._guild.upEmblem.idEmblem);
                    if (_local_2.colorizable)
                    {
                        this.utilApi.changeColor(this.tx_emblemUp.getChildByName("up"), this._guild.upEmblem.color, 0);
                    }
                    else
                    {
                        this.utilApi.changeColor(this.tx_emblemUp.getChildByName("up"), this._guild.upEmblem.color, 0, true);
                    };
                    this.tx_emblemUp.visible = true;
                    break;
            };
        }


    }
}//package ui

