package ui
{
    import d2api.TooltipApi;
    import d2api.UiApi;
    import d2components.GraphicContainer;
    import d2components.Label;
    import d2components.Texture;
    import d2hooks.*;

    public class WorldRpFightTooltipUi 
    {

        public var tooltipApi:TooltipApi;
        public var uiApi:UiApi;
        public var mainCtr:GraphicContainer;
        public var levelCtr:GraphicContainer;
        public var waveCtr:GraphicContainer;
        public var lbl_fightersList:Label;
        public var lbl_nbWaves:Label;
        public var tx_wave:Texture;


        public function main(oParam:Object=null):void
        {
            var fighter:Object;
            var hasWaves:Boolean = (oParam.data.nbWaves > 0);
            var fightersList:String = "";
            for each (fighter in oParam.data.fighters)
            {
                if (fighter.allianceTag)
                {
                    fightersList = (fightersList + (fighter.allianceTag + " "));
                };
                fightersList = (fightersList + (((((fighter.name + " (") + Api.ui.getText("ui.common.short.level")) + " ") + fighter.level) + ")\n"));
            };
            this.lbl_fightersList.text = fightersList;
            if (!(hasWaves))
            {
                this.waveCtr.visible = false;
                this.lbl_fightersList.y = (this.levelCtr.y + this.levelCtr.height);
            }
            else
            {
                this.waveCtr.visible = true;
                this.waveCtr.y = (this.levelCtr.y + this.levelCtr.height);
                this.lbl_nbWaves.text = ("x " + oParam.data.nbWaves);
                this.lbl_nbWaves.fullWidth();
                this.tx_wave.x = ((this.mainCtr.width / 2) - ((this.tx_wave.width + this.lbl_nbWaves.width) / 2));
                this.lbl_nbWaves.x = (this.tx_wave.x + this.tx_wave.width);
                this.lbl_fightersList.y = (this.waveCtr.y + this.waveCtr.height);
            };
            this.mainCtr.height = this.mainCtr.contentHeight;
            this.tooltipApi.place(oParam.position, oParam.point, oParam.relativePoint, oParam.offset);
            var w:Number = (this.mainCtr.width / 2);
            this.levelCtr.x = (int((w - (this.levelCtr.width / 2))) - 2);
        }

        public function unload():void
        {
        }


    }
}//package ui

