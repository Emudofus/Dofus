package ui
{
    import d2components.GraphicContainer;
    import d2components.Texture;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2hooks.*;
    import d2actions.*;

    public class ImagePopup extends Popup 
    {

        public var imgPopCtr:GraphicContainer;
        public var ctr_contents:Object;
        public var tx_image:Texture;


        override public function main(param:Object):void
        {
            var ie:Object;
            var btn:ButtonContainer;
            var btnTx:Texture;
            var btnLbl:Label;
            var s:String;
            var stateChangingProperties:Array;
            tx_background.autoGrid = true;
            lbl_content.multiline = true;
            lbl_content.wordWrap = true;
            lbl_content.html = true;
            lbl_content.border = false;
            if (param)
            {
                if (param.hideModalContainer)
                {
                    this.imgPopCtr.getUi().showModalContainer = false;
                }
                else
                {
                    this.imgPopCtr.getUi().showModalContainer = true;
                };
                lbl_title.text = param.title;
                this.tx_image.uri = param.image;
                s = param.content;
                lbl_content.text = s;
                if (((!(param.buttonText)) || (!(param.buttonText.length))))
                {
                    throw (new Error("Can't create popup without any button"));
                };
            }
            else
            {
                throw (new Error("Can't load popup without properties."));
            };
            var btnWidth:uint = 100;
            var btnHeight:uint = 32;
            var padding:uint = 20;
            sysApi.log(8, ((("texte height : " + lbl_content.height) + " \n\n") + param.content));
            var imageHeight:uint = this.tx_image.height;
            var contentHeight:uint = lbl_content.height;
            var textHeight:uint = lbl_content.textfield.textHeight;
            this.imgPopCtr.height = (Math.floor((((textHeight > this.tx_image.height)) ? textHeight : this.tx_image.height)) + 150);
            var i:uint;
            while (i < param.buttonText.length)
            {
                btn = (uiApi.createContainer("ButtonContainer") as ButtonContainer);
                btn.width = btnWidth;
                btn.height = btnHeight;
                btn.x = (i * (padding + btnWidth));
                btn.name = ("btn" + (i + 1));
                uiApi.me().registerId(btn.name, uiApi.createContainer("GraphicElement", btn, new Array(), btn.name));
                btnTx = (uiApi.createComponent("Texture") as Texture);
                btnTx.width = btnWidth;
                btnTx.height = btnHeight;
                btnTx.uri = uiApi.createUri(uiApi.me().getConstant("btn.file"));
                btnTx.autoGrid = true;
                btnTx.name = (btn.name + "_tx");
                uiApi.me().registerId(btnTx.name, uiApi.createContainer("GraphicElement", btnTx, new Array(), btnTx.name));
                btnTx.finalize();
                btnLbl = (uiApi.createComponent("Label") as Label);
                btnLbl.width = btnWidth;
                btnLbl.height = btnHeight;
                btnLbl.verticalAlign = "center";
                btnLbl.css = uiApi.createUri(uiApi.me().getConstant("btn.css"));
                btnLbl.text = uiApi.replaceKey(param.buttonText[i]);
                btn.addChild(btnTx);
                btn.addChild(btnLbl);
                stateChangingProperties = new Array();
                stateChangingProperties[1] = new Array();
                stateChangingProperties[1][btnTx.name] = new Array();
                stateChangingProperties[1][btnTx.name]["gotoAndStop"] = "over";
                stateChangingProperties[2] = new Array();
                stateChangingProperties[2][btnTx.name] = new Array();
                stateChangingProperties[2][btnTx.name]["gotoAndStop"] = "pressed";
                btn.changingStateData = stateChangingProperties;
                if (((param.buttonCallback) && (param.buttonCallback[i])))
                {
                    _aEventIndex[btn.name] = param.buttonCallback[i];
                };
                uiApi.addComponentHook(btn, "onRelease");
                ctr_buttons.addChild(btn);
                i++;
            };
            if (param.onCancel)
            {
                onCancelFunction = param.onCancel;
            };
            uiApi.me().render();
        }


    }
}//package ui

