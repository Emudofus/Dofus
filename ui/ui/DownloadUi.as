package ui
{
    import d2api.UiApi;
    import d2api.SystemApi;
    import d2components.GraphicContainer;
    import d2components.Texture;
    import d2components.Label;
    import d2components.ButtonContainer;
    import d2hooks.PartInfo;
    import d2hooks.DownloadError;
    import d2actions.*;
    import d2hooks.*;

    public class DownloadUi 
    {

        public static const PART_NOT_INSTALLED:uint = 0;
        public static const PART_BEING_UPDATER:uint = 1;
        public static const PART_UP_TO_DATE:uint = 2;
        private static const STATE_PROGRESS:int = 0;
        private static const STATE_FINISHED:int = 1;
        private static const STATE_ERROR:int = 2;

        public var uiApi:UiApi;
        public var sysApi:SystemApi;
        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var mainCtr:GraphicContainer;
        public var tx_progressBar:Texture;
        public var tx_progressBarBackground:Texture;
        public var lbl_largeProgressValue:Label;
        public var lbl_tinyProgressValue:Label;
        public var btn_loadingBG:ButtonContainer;
        public var ctr_large:GraphicContainer;
        public var ctr_tiny:GraphicContainer;
        public var ctr_progress:GraphicContainer;
        public var lbl_message:Label;
        private var _partId:uint;
        private var _folded:Boolean;
        private var _state:int;


        public function set folded(fold:Boolean):void
        {
            this._folded = fold;
            this.btn_loadingBG.selected = true;
            if (fold)
            {
                this.ctr_large.visible = false;
                this.ctr_tiny.visible = true;
            }
            else
            {
                this.btn_loadingBG.selected = false;
                this.ctr_large.visible = true;
                this.ctr_tiny.visible = false;
            };
        }

        public function get folded():Boolean
        {
            return (this._folded);
        }

        public function set visible(v:Boolean):void
        {
            this.mainCtr.visible = v;
        }

        public function get visible():Boolean
        {
            return (this.mainCtr.visible);
        }

        public function main(args:Object):void
        {
            if (args.hasOwnProperty("id"))
            {
                this._partId = args.id;
            };
            if (args.hasOwnProperty("state"))
            {
                this.state = args.state;
            }
            else
            {
                this.state = STATE_PROGRESS;
            };
            this.sysApi.addHook(PartInfo, this.onPartInfo);
            this.sysApi.addHook(DownloadError, this.onDownloadError);
            this.uiApi.addComponentHook(this.btn_loadingBG, "onRelease");
        }

        public function onPartInfo(part:Object, downloadPercent:Number):void
        {
            if (part.state == PART_BEING_UPDATER)
            {
                this.state = STATE_PROGRESS;
                this._partId = part.id;
                if (downloadPercent == 100)
                {
                    this.state = STATE_FINISHED;
                }
                else
                {
                    this.updateProgressBar(int(downloadPercent));
                };
            }
            else
            {
                if ((((this._partId == part.id)) && ((part.state == PART_UP_TO_DATE))))
                {
                    this.state = STATE_FINISHED;
                };
            };
        }

        public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_loadingBG:
                    this.folded = this.btn_loadingBG.selected;
                    break;
            };
        }

        public function onDownloadError(errorId:int, message:String, url:String):void
        {
            var errorMessage:String;
            this.state = STATE_ERROR;
            if (message)
            {
                errorMessage = message;
                if (url)
                {
                    errorMessage = (errorMessage + ("\n" + url));
                };
            }
            else
            {
                if (errorId == 3)
                {
                    errorMessage = "internal error : bad pack id";
                };
                this.sysApi.log(8, "internal error : bad pack id");
            };
            errorMessage = (errorMessage + ("\n" + this.uiApi.getText("ui.split.rebootOnError")));
            this.modCommon.openPopup(this.uiApi.getText("ui.common.error"), errorMessage, [this.uiApi.getText("ui.common.yes"), this.uiApi.getText("ui.common.no")], [this.onReboot, this.emptyFunction], this.onReboot, this.emptyFunction);
        }

        public function onReboot():void
        {
            this.sysApi.reset();
        }

        public function emptyFunction():void
        {
        }

        private function set state(s:int):void
        {
            this._state = s;
            switch (this._state)
            {
                case STATE_PROGRESS:
                    this.ctr_progress.visible = true;
                    this.lbl_message.visible = false;
                    break;
                case STATE_ERROR:
                    this.ctr_progress.visible = false;
                    this.lbl_message.visible = true;
                    this.lbl_message.text = this.uiApi.getText("ui.streaming.downloadError");
                    break;
                case STATE_FINISHED:
                    this.ctr_progress.visible = false;
                    this.lbl_message.visible = true;
                    this.lbl_message.text = this.uiApi.getText("ui.streaming.downloadFinished");
                    this.updateProgressBar(100);
                    break;
            };
        }

        private function updateProgressBar(pos:uint):void
        {
            this.tx_progressBar.width = ((this.tx_progressBarBackground.width * pos) / 100);
            this.lbl_largeProgressValue.text = (pos + "%");
            this.lbl_tinyProgressValue.text = (pos + "%");
        }

        private function setFinished():void
        {
            this.lbl_message.text = this.uiApi.getText("ui.streaming.downloadError");
            this.lbl_message.visible = true;
        }


    }
}//package ui

