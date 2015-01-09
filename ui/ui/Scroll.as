package ui
{
    import d2api.DocumentApi;
    import d2api.SoundApi;
    import d2components.ButtonContainer;
    import d2components.Label;
    import d2components.TextArea;
    import d2components.Texture;
    import d2components.GraphicContainer;
    import flash.text.StyleSheet;
    import data.ImageData;
    import com.ankamagames.dofusModuleLibrary.enum.SoundTypeEnum;
    import d2actions.LeaveDialogRequest;
    import tools.HtmlParser;
    import d2actions.*;

    public class Scroll extends DocumentBase 
    {

        private static var EXP_TAG:RegExp = /(<[a-zA-Z]+\s*[^>]*+>)+([^<].*?)/gi;

        private const MAX_LINES:int = 30;

        [Module(name="Ankama_Common")]
        public var modCommon:Object;
        public var docApi:DocumentApi;
        public var soundApi:SoundApi;
        public var btn_close:ButtonContainer;
        public var btn_close2:ButtonContainer;
        public var lbl_title:Label;
        public var lbl_content:TextArea;
        public var tx_illu:Texture;
        public var mainCtr:GraphicContainer;
        public var tx_deco:Texture;
        public var tx_background:Texture;
        private var _styleSheet:StyleSheet;
        private var _title:String;
        private var _pages:Array;
        private var _image:ImageData;
        private var _illuUri:Object;
        private var _hasText:Boolean = true;


        public function main(params:Object):void
        {
            this.soundApi.playSound(SoundTypeEnum.MAP_OPEN);
            uiApi.addShortcutHook("closeUi", this.onShortcut);
            if ((((sysApi.getBuildType() == 4)) || ((sysApi.getBuildType() == 5))))
            {
                this.lbl_content.textfield.doubleClickEnabled = true;
                uiApi.addComponentHook(this.lbl_content, "onDoubleClick");
            };
            var document:Object = this.docApi.getDocument(params.documentId);
            this._title = document.title;
            this._pages = new Array();
            this._pages[0] = document.pages[0];
            if (((this._pages[0]) && (this._pages[0].length)))
            {
                this.preInitData();
                this.initCss(document);
                this._initScroll();
            }
            else
            {
                sysApi.enableWorldInteraction();
                sysApi.sendAction(new LeaveDialogRequest());
                uiApi.unloadUi(uiApi.me().name);
            };
        }

        private function preInitData():void
        {
            this._hasText = this.documentHasText(this._pages[0]);
            this._image = getImageData(this._pages[0]);
            if (this._image != null)
            {
                this._illuUri = uiApi.createUri((uiApi.me().getConstant("illus") + this._image.src));
            };
        }

        private function initCss(document:Object):void
        {
            if (((document.contentCSS) && (!((document.contentCSS == "null")))))
            {
                this._styleSheet = new StyleSheet();
                this._styleSheet.parseCSS(document.contentCSS);
                overrideLinkStyleInCss(this._styleSheet);
                this.lbl_content.setStyleSheet(this._styleSheet);
            };
        }

        public function unload():void
        {
            this.soundApi.playSound(SoundTypeEnum.MAP_CLOSE);
            sysApi.enableWorldInteraction();
            sysApi.sendAction(new LeaveDialogRequest());
        }

        private function _initScroll():void
        {
            var text:String;
            this.lbl_title.text = (((this._title.search("<b>"))==-1) ? (("<b>" + this._title) + "</b>") : this._title);
            if (this._styleSheet)
            {
                text = formateText(this._pages[0]);
            }
            else
            {
                text = HtmlParser.parseText(this._pages[0]);
            };
            if (((!(this._hasText)) && (!((this._image == null)))))
            {
                this.btn_close.visible = false;
                this.lbl_title.visible = false;
                this.tx_deco.visible = false;
                this.tx_background.visible = false;
                this.lbl_content.visible = false;
                if (this._image.width > 0)
                {
                    this.tx_illu.width = this._image.width;
                }
                else
                {
                    this.tx_illu.width = 354;
                };
                if (this._image.height > 0)
                {
                    this.tx_illu.height = this._image.height;
                }
                else
                {
                    this.tx_illu.height = 539;
                };
                this.tx_illu.x = (150 + ((800 - this.tx_illu.width) / 2));
                this.tx_illu.y = (130 + ((600 - this.tx_illu.height) / 2));
                this.tx_illu.uri = this._illuUri;
                this.btn_close2.x = ((this.tx_illu.x + this._image.width) - this.btn_close.width);
                this.btn_close2.y = (this.tx_illu.y - this.btn_close.height);
                this.btn_close2.visible = true;
            }
            else
            {
                this.btn_close2.visible = false;
                this.btn_close.visible = true;
                if (this._illuUri)
                {
                    this.lbl_content.width = 490;
                }
                else
                {
                    this.lbl_content.width = 800;
                };
                this.lbl_content.text = ((((this._image == null)) ? "\n" : "") + text);
                this.lbl_content.visible = true;
                this.lbl_content.textfield.mouseEnabled = true;
                this.lbl_content.textfield.multiline = true;
                this.lbl_content.wordWrap = true;
                uiApi.addComponentHook(this.lbl_content, "onTextClick");
                if ((((this.lbl_content.textHeight > this.lbl_content.height)) && (((this.lbl_content.textHeight - this.lbl_content.height) < 10))))
                {
                    this.lbl_content.height = this.lbl_content.textHeight;
                };
                this.tx_illu.x = 643;
                this.tx_illu.y = 148;
                if (this._image != null)
                {
                    if (this._image.width > 0)
                    {
                        this.tx_illu.width = this._image.width;
                    }
                    else
                    {
                        this.tx_illu.width = 354;
                    };
                    if (this._image.height > 0)
                    {
                        this.tx_illu.height = this._image.height;
                    }
                    else
                    {
                        this.tx_illu.height = 539;
                    };
                    this.tx_illu.uri = this._illuUri;
                };
                if (this.lbl_content.textfield.numLines <= this.MAX_LINES)
                {
                    this.lbl_content.hideScrollBar();
                };
            };
        }

        public function documentHasText(page:String):Boolean
        {
            var data:* = new RegExp(EXP_TAG).exec(page);
            return (!((data == null)));
        }

        public function onTextClick(target:Object, textEvent:String):void
        {
            linkHandler(textEvent);
        }

        override public function onRelease(target:Object):void
        {
            switch (target)
            {
                case this.btn_close:
                case this.btn_close2:
                    uiApi.unloadUi(uiApi.me().name);
                    break;
            };
            super.onRelease(target);
        }

        public function onShortcut(s:String):Boolean
        {
            switch (s)
            {
                case "closeUi":
                    uiApi.unloadUi(uiApi.me().name);
                    return (true);
            };
            return (false);
        }

        public function onDoubleClick(target:Object):void
        {
            if (target == this.lbl_content)
            {
                openDebugEditionPanel(this.lbl_content, this._pages[0], 480);
            };
        }

        override public function updateDocumentContent(pParentCtr:GraphicContainer, pNewText:String):void
        {
            this._pages[0] = pNewText;
            this.preInitData();
            this._initScroll();
        }

        override public function copyAllDataToClipBoard():void
        {
            sysApi.copyToClipboard(this._pages[0]);
        }


    }
}//package ui

