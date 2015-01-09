package ui
{
    import d2components.GraphicContainer;
    import flash.text.AntiAliasType;

    public class ChatComponentHandler 
    {

        public static const CHAT_ADVANCED:String = "advanced";
        public static const CHAT_NORMAL:String = "normal";

        private var _type:String;
        private var _chat:Object;
        private var _parent:GraphicContainer;

        public function ChatComponentHandler(pType:String, pParent:GraphicContainer)
        {
            this._parent = pParent;
            this._type = pType;
            Api.chat.setMaxMessagesStored(100);
            if (this._type == CHAT_ADVANCED)
            {
                Api.chat.changeCssHandler("inline");
                this._chat = Api.ui.createComponent("ChatComponent");
                this._chat.width = 488;
                this._chat.height = 105;
                this._chat.smiliesActivated = false;
                this._chat.css = Api.ui.createUri((Api.ui.getUi("chat").getConstant("css") + "chat.css"));
            }
            else
            {
                Api.chat.changeCssHandler("old");
                this._chat = Api.ui.createComponent("TextArea");
                this._chat.name = "ta_chat";
                this._chat.width = 488;
                this._chat.height = 113;
                this._chat.selectable = true;
                this._chat.useEmbedFonts = false;
                this._chat.hyperlinkEnabled = true;
                if (this._chat.hasOwnProperty("antialias"))
                {
                    this._chat.antialias = AntiAliasType.ADVANCED;
                };
                this._chat.css = Api.ui.createUri((Api.ui.getUi("chat").getConstant("css") + "chat_input.css"));
                this._chat.cssClass = "p";
            };
            this._parent.addContent((this._chat as GraphicContainer));
            this._chat.x = 2;
            this._chat.y = 27;
            this._chat.scrollCss = Api.ui.createUri((Api.ui.getUi("chat").getConstant("css") + "scrollBar.css"));
            this._chat.scrollTopMargin = 5;
            this._chat.scrollPos = -7;
            this._chat.finalize();
        }

        public function setCssColor(color:String, style:String=null):void
        {
            this._chat.setCssColor(color, style);
        }

        public function setCssSize(size:uint, lineHeight:uint, style:String=null):void
        {
            if (this._type == CHAT_ADVANCED)
            {
                this._chat.setCssSize(size, lineHeight, style);
            }
            else
            {
                this._chat.setCssSize(size, style);
            };
        }

        public function initSmileyTab(uri:String, data:Object):void
        {
            if (this._type == CHAT_ADVANCED)
            {
                this._chat.initSmileyTab(uri, data);
            };
        }

        public function appendText(sTxt:String, style:String=null, addToChat:Boolean=true):Object
        {
            if (this._type == CHAT_ADVANCED)
            {
                return (this._chat.appendText(sTxt, style, addToChat));
            };
            if (addToChat)
            {
                this._chat.appendText(sTxt, style);
            };
            return (null);
        }

        public function clearText():void
        {
            if (this._type == CHAT_ADVANCED)
            {
                this._chat.clearText();
            }
            else
            {
                this._chat.text = "";
            };
        }

        public function getTextForChannel(channelToShow:*):Object
        {
            if (this._type == CHAT_ADVANCED)
            {
                return (Api.chat.getParagraphByChannel(channelToShow));
            };
            return (Api.chat.getMessagesByChannel(channelToShow));
        }

        public function getHistoryForChannel(channelToShow:*):Object
        {
            return (Api.chat.getHistoryMessagesByChannel(channelToShow));
        }

        public function insertParagraphes(data:Array):void
        {
            if (this._type == CHAT_ADVANCED)
            {
                this._chat.insertParagraphes(data);
            };
        }

        public function activeSmilies():void
        {
            if (this._type == CHAT_ADVANCED)
            {
                this._chat.smiliesActivated = !(this._chat.smiliesActivated);
            };
        }

        public function removeLines(val:int):void
        {
            var idel:uint;
            var htmlText:String;
            var index:uint;
            if (this._type == CHAT_ADVANCED)
            {
                this._chat.removeLines(val);
            }
            else
            {
                htmlText = this._chat.htmlText;
                idel = 0;
                while (idel < val)
                {
                    index = (htmlText.indexOf("</TEXTFORMAT>") + 13);
                    htmlText = htmlText.substr(index);
                    idel++;
                };
                this._chat.htmlText = htmlText;
            };
        }

        public function scrollNeeded():Boolean
        {
            if (this._type == CHAT_ADVANCED)
            {
                return ((this._chat.scrollV == this._chat.maxScrollV));
            };
            return ((((this._chat.scrollV == this._chat.maxScrollV)) || ((this._chat.maxScrollV <= 6))));
        }

        public function get height():Number
        {
            return (this._chat.height);
        }

        public function set height(val:Number):void
        {
            this._chat.height = val;
        }

        public function get scrollV():Number
        {
            return (this._chat.scrollV);
        }

        public function set scrollV(val:Number):void
        {
            this._chat.scrollV = val;
        }

        public function get maxScrollV():Number
        {
            return (this._chat.maxScrollV);
        }

        public function set maxScrollV(val:Number):void
        {
            this._chat.maxScrollV = val;
        }

        public function get type():String
        {
            return (this._type);
        }

        public function get text():String
        {
            return (this._chat.text);
        }

        public function get htmlText():String
        {
            var txt:String;
            if (this.type == CHAT_NORMAL)
            {
                txt = this._chat.htmlText;
            };
            return (txt);
        }

        public function set htmlText(pText:String):void
        {
            if (this.type == CHAT_NORMAL)
            {
                this._chat.htmlText = pText;
            };
        }


    }
}//package ui

