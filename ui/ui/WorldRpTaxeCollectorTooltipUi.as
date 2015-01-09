package ui
{
    import d2api.TooltipApi;
    import d2api.UiApi;
    import d2api.UtilApi;
    import d2api.DataApi;
    import d2data.GuildWrapper;
    import d2data.AllianceWrapper;
    import d2components.Label;
    import d2components.GraphicContainer;
    import d2components.Texture;
    import d2data.EmblemSymbol;
    import d2hooks.*;

    public class WorldRpTaxeCollectorTooltipUi 
    {

        public var tooltipApi:TooltipApi;
        public var uiApi:UiApi;
        public var utilApi:UtilApi;
        public var dataApi:DataApi;
        private var _guild:GuildWrapper;
        private var _alliance:AllianceWrapper;
        public var lbl_guildName:Label;
        public var lbl_playerName:Label;
        public var infosCtr:GraphicContainer;
        public var tx_back:GraphicContainer;
        public var tx_emblemBack:Texture;
        public var tx_emblemUp:Texture;
        public var tx_AllianceEmblemBack:Texture;
        public var tx_AllianceEmblemUp:Texture;


        public function main(oParam:Object=null):void
        {
            var maxWidth:Number;
            var center:Number;
            this.tx_back.width = 1;
            this.tx_back.removeFromParent();
            this.tx_emblemBack.dispatchMessages = true;
            this.uiApi.addComponentHook(this.tx_emblemBack, "onTextureReady");
            this.tx_emblemUp.dispatchMessages = true;
            this.uiApi.addComponentHook(this.tx_emblemUp, "onTextureReady");
            this._guild = oParam.data.guildIdentity;
            this.tx_emblemBack.uri = this._guild.backEmblem.fullSizeIconUri;
            this.tx_emblemUp.uri = this._guild.upEmblem.fullSizeIconUri;
            this.lbl_playerName.text = ((oParam.data.lastName + " ") + oParam.data.firstName);
            this._alliance = oParam.data.allianceIdentity;
            if (this._alliance)
            {
                this.lbl_guildName.appendText(((" - [" + oParam.data.allianceIdentity.allianceTag) + "]"));
                this.lbl_guildName.fullWidth();
                this.tx_AllianceEmblemBack.dispatchMessages = true;
                this.uiApi.addComponentHook(this.tx_AllianceEmblemBack, "onTextureReady");
                this.tx_AllianceEmblemBack.uri = this.uiApi.createUri((((this.uiApi.me().getConstant("emblems") + "backalliance/") + this._alliance.backEmblem.idEmblem) + ".swf"));
                this.tx_AllianceEmblemUp.dispatchMessages = true;
                this.uiApi.addComponentHook(this.tx_AllianceEmblemUp, "onTextureReady");
                this.tx_AllianceEmblemUp.uri = this._alliance.upEmblem.fullSizeIconUri;
                this.tx_AllianceEmblemBack.y = this.tx_emblemBack.y;
                maxWidth = this.lbl_guildName.width;
                this.lbl_playerName.fullWidth();
                if (this.lbl_playerName.width > maxWidth)
                {
                    maxWidth = this.lbl_playerName.width;
                };
                this.tx_back.width = (((50 + maxWidth) + this.tx_AllianceEmblemBack.width) + 16);
                this.tx_AllianceEmblemBack.x = ((this.tx_back.width - 8) - this.tx_AllianceEmblemBack.width);
                this.tx_AllianceEmblemUp.y = this.tx_emblemUp.y;
                this.tx_AllianceEmblemUp.x = (this.tx_AllianceEmblemBack.x + 8);
                this.infosCtr.width = (this.tx_back.width - 10);
                center = (((this.tx_emblemBack.x + this.tx_emblemBack.width) + this.tx_AllianceEmblemBack.x) / 2);
                this.lbl_guildName.x = (center - (this.lbl_guildName.width / 2));
                this.lbl_playerName.x = (center - (this.lbl_playerName.width / 2));
            };
            this.infosCtr.addContent(this.tx_back, 0);
            this.tooltipApi.place(oParam.position, oParam.point, oParam.relativePoint, oParam.offset);
        }

        private function updateEmblemBack(pTexture:Texture, pColor:int):void
        {
            this.utilApi.changeColor(pTexture.getChildByName("back"), pColor, 1);
            pTexture.visible = true;
        }

        private function updateEmblemUp(pTexture:Texture, pColor:int, pSymbolId:int):void
        {
            var icon:EmblemSymbol = this.dataApi.getEmblemSymbol(pSymbolId);
            if (icon.colorizable)
            {
                this.utilApi.changeColor(pTexture.getChildByName("up"), pColor, 0);
            }
            else
            {
                this.utilApi.changeColor(pTexture.getChildByName("up"), pColor, 0, true);
            };
            pTexture.visible = true;
        }

        public function onTextureReady(target:Object):void
        {
            switch (target)
            {
                case this.tx_emblemBack:
                    this.updateEmblemBack(this.tx_emblemBack, this._guild.backEmblem.color);
                    break;
                case this.tx_emblemUp:
                    this.updateEmblemUp(this.tx_emblemUp, this._guild.upEmblem.color, this._guild.upEmblem.idEmblem);
                    break;
                case this.tx_AllianceEmblemBack:
                    this.updateEmblemBack(this.tx_AllianceEmblemBack, this._alliance.backEmblem.color);
                    break;
                case this.tx_AllianceEmblemUp:
                    this.updateEmblemUp(this.tx_AllianceEmblemUp, this._alliance.upEmblem.color, this._alliance.upEmblem.idEmblem);
                    break;
            };
        }

        public function unload():void
        {
        }


    }
}//package ui

