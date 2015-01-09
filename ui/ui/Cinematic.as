package ui
{
    import d2api.UiApi;
    import d2api.SystemApi;
    import d2api.SoundApi;
    import d2components.ButtonContainer;
    import d2components.GraphicContainer;
    import d2components.VideoPlayer;
    import d2components.Texture;
    import d2components.Label;
    import flash.utils.Timer;
    import d2hooks.StopCinematic;
    import d2hooks.MapComplementaryInformationsData;
    import d2hooks.ActivateSound;
    import flash.events.TimerEvent;
    import flash.events.Event;
    import d2actions.*;
    import d2hooks.*;

    public class Cinematic 
    {

        public var uiApi:UiApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var sysApi:SystemApi;
        public var soundApi:SoundApi;
        private var _hasFlushed:Boolean = false;
        public var btn_skip:ButtonContainer;
        public var mainCtr:GraphicContainer;
        public var vplayer:VideoPlayer;
        public var tx_loading:Texture;
        public var tx_loading_bg:Texture;
        public var lb_loading:Label;
        private var _timeout:Boolean;
        private var _timer:Timer;


        public function main(args:Object):void
        {
            var gfxPath:String = this.sysApi.getConfigEntry("config.gfx.path.cinematic");
            var file:String = ((gfxPath + args.cinematicId) + ".flv");
            this.sysApi.log(8, ("Ouverture de la vidéo " + file));
            this.uiApi.addComponentHook(this.vplayer, "onVideoConnectFailed");
            this.uiApi.addComponentHook(this.vplayer, "onVideoConnectSuccess");
            this.uiApi.addComponentHook(this.vplayer, "onVideoBufferChange");
            this.sysApi.addHook(StopCinematic, this.onStopCinematic);
            this.sysApi.addHook(MapComplementaryInformationsData, this.onMapComplementaryInformationsData);
            this.sysApi.addHook(ActivateSound, this.onActivateSound);
            this.uiApi.addShortcutHook("closeUi", this.onShortcut);
            this.vplayer.mute = !(this.soundApi.soundsAreActivated());
            this.vplayer.flv = file;
            this.vplayer.connect();
            this.sysApi.showWorld(false);
            this.soundApi.activateSounds(false);
            if (this.uiApi.getUi("mapInfo"))
            {
                this.uiApi.getUi("mapInfo").uiClass.visible = false;
            };
            this.vplayer.width = this.mainCtr.width;
            this.vplayer.height = this.mainCtr.height;
            this._timer = new Timer(2000, 1);
            this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
            this._timeout = false;
            this._timer.start();
        }

        public function unload():void
        {
            this.sysApi.log(8, "Fermeture de l'interface vidéo");
            this.sysApi.showWorld(true);
            this.soundApi.activateSounds(true);
            if (this.uiApi.getUi("mapInfo"))
            {
                this.uiApi.getUi("mapInfo").uiClass.visible = true;
            };
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_skip:
                    this.sysApi.dispatchHook(StopCinematic);
                    break;
            };
        }

        public function onRollOver(target:Object):void
        {
            var tooltipText:String;
            var data:Object;
            var point:uint = 7;
            var relPoint:uint = 1;
            switch (target)
            {
                case this.btn_skip:
                    tooltipText = this.uiApi.getText("ui.cancel.cinematic");
                    break;
            };
            data = this.uiApi.textTooltipInfo(tooltipText);
            this.uiApi.showTooltip(data, target, false, "standard", point, relPoint, 3, null, null, null, "TextInfo");
        }

        public function onRollOut(target:Object):void
        {
            this.uiApi.hideTooltip();
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "closeUi":
                    this.vplayer.stop();
                    this.sysApi.dispatchHook(StopCinematic);
                    break;
            };
            return (false);
        }

        public function onVideoConnectFailed(target:Object):void
        {
            switch (target)
            {
                case this.vplayer:
                    this.sysApi.log(16, ("Echec de la lecture de la vidéo " + this.vplayer.flv));
                    this.sysApi.dispatchHook(StopCinematic);
                    break;
            };
        }

        public function dispatchQuitCinematic():void
        {
            this.sysApi.dispatchHook(StopCinematic);
        }

        public function onVideoConnectSuccess(target:Object):void
        {
            switch (target)
            {
                case this.vplayer:
                    this.vplayer.play();
                    break;
            };
        }

        public function onVideoBufferChange(target:Object, state:uint):void
        {
            if (target == this.vplayer)
            {
                this.sysApi.log(8, (((("Changement d'état du buffer vidéo : " + state) + "     (timeout ") + this._timeout) + ")"));
                switch (state)
                {
                    case 0:
                        this.tx_loading.visible = false;
                        this.lb_loading.visible = false;
                        this.tx_loading_bg.visible = false;
                        break;
                    case 1:
                        if (((this._timeout) && (this._hasFlushed)))
                        {
                            this.vplayer.stop();
                            this.sysApi.dispatchHook(StopCinematic);
                        };
                        break;
                    case 2:
                        this._hasFlushed = true;
                        break;
                };
            };
        }

        public function onMapComplementaryInformationsData(map:Object, subAreaId:uint, show:Boolean):void
        {
            this.sysApi.showWorld(false);
        }

        private function onStopCinematic():void
        {
            this.vplayer.stop();
            this.uiApi.unloadUi(this.uiApi.me().name);
        }

        public function onActivateSound(pActive:Boolean):void
        {
            this.vplayer.mute = !(pActive);
        }

        public function onTimeOut(event:Event):void
        {
            this._timeout = true;
        }


    }
}//package ui

