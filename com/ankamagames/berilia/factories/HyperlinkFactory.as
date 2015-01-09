package com.ankamagames.berilia.factories
{
    import flash.utils.Dictionary;
    import flash.text.StyleSheet;
    import flash.utils.Timer;
    import flash.text.TextField;
    import flash.events.TextEvent;
    import flash.events.EventDispatcher;
    import com.ankamagames.berilia.events.LinkInteractionEvent;
    import com.ankamagames.berilia.managers.HtmlManager;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.jerakine.utils.display.FrameIdManager;
    import com.ankamagames.jerakine.utils.display.StageShareManager;
    import com.ankamagames.berilia.frames.ShortcutsFrame;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.berilia.utils.BeriliaHookList;
    import flash.events.TimerEvent;

    public class HyperlinkFactory 
    {

        private static var LEFT:String = "{";
        private static var RIGHT:String = "}";
        private static var SEPARATOR:String = "::";
        private static var PROTOCOL:Dictionary = new Dictionary();
        private static var PROTOCOL_TEXT:Dictionary = new Dictionary();
        private static var PROTOCOL_SHIFT:Dictionary = new Dictionary();
        private static var PROTOCOL_BOLD:Dictionary = new Dictionary();
        private static var PROTOCOL_ROLL_OVER:Dictionary = new Dictionary();
        private static var staticStyleSheet:StyleSheet;
        public static var lastClickEventFrame:uint;
        private static var _rollOverTimer:Timer;
        private static var _rollOverData:String;


        public static function protocolIsRegister(protocolName:String):Boolean
        {
            return (((PROTOCOL[protocolName]) ? true : false));
        }

        public static function textProtocolIsRegister(protocolName:String):Boolean
        {
            return (((PROTOCOL_TEXT[protocolName]) ? true : false));
        }

        public static function shiftProtocolIsRegister(protocolName:String):Boolean
        {
            return (((PROTOCOL_SHIFT[protocolName]) ? true : false));
        }

        public static function boldProtocolIsRegister(protocolName:String):Boolean
        {
            return (((PROTOCOL_BOLD[protocolName]) ? true : false));
        }

        public static function createTextClickHandler(component:EventDispatcher, styleSheet:Boolean=false):void
        {
            var t:TextField;
            if ((component is TextField))
            {
                t = (component as TextField);
                t.htmlText = decode(t.htmlText, true, ((styleSheet) ? t : null));
                t.mouseEnabled = true;
            };
            component.addEventListener(TextEvent.LINK, processClick);
        }

        public static function createRollOverHandler(component:EventDispatcher):void
        {
            component.addEventListener(LinkInteractionEvent.ROLL_OVER, processRollOver);
            component.addEventListener(LinkInteractionEvent.ROLL_OUT, processRollOut);
        }

        public static function activeSmallHyperlink(textField:TextField):void
        {
            textField.addEventListener(TextEvent.LINK, processClick);
        }

        public static function decode(string:String, htmlMode:Boolean=true, textField:TextField=null):String
        {
            var leftIndex:int;
            var rightIndex:int;
            var leftBlock:String;
            var rightBlock:String;
            var middleBlock:String;
            var linkInfo:Array;
            var param:String;
            var paramList:Array;
            var protocolName:String;
            var linkColor:String;
            var hoverColor:String;
            var i:int;
            var nbParams:int;
            var p:String;
            var getTextFunction:Function;
            var text:String;
            var customStyleSheet:Boolean;
            var styleSheet:StyleSheet;
            var currentText:String = string;
            while (true)
            {
                leftIndex = currentText.indexOf(LEFT);
                if (leftIndex == -1) break;
                rightIndex = currentText.indexOf(RIGHT);
                if (rightIndex == -1) break;
                if (leftIndex > rightIndex) break;
                leftBlock = currentText.substring(0, leftIndex);
                rightBlock = currentText.substring((rightIndex + 1));
                middleBlock = currentText.substring(leftIndex, rightIndex);
                linkInfo = middleBlock.split("::");
                param = linkInfo[0].substr(1);
                paramList = param.split(",");
                protocolName = paramList.shift();
                nbParams = paramList.length;
                i = 0;
                while (i < nbParams)
                {
                    p = paramList[i];
                    if (p.indexOf("linkColor") != -1)
                    {
                        linkColor = p.split(":")[1];
                        paramList.splice(i, 1);
                        i--;
                        nbParams--;
                    };
                    if (p.indexOf("hoverColor") != -1)
                    {
                        hoverColor = p.split(":")[1];
                        paramList.splice(i, 1);
                        i--;
                        nbParams--;
                    };
                    i++;
                };
                if (((linkColor) || (hoverColor)))
                {
                    param = ((protocolName + ",") + paramList.join(","));
                };
                if (linkInfo.length == 1)
                {
                    getTextFunction = PROTOCOL_TEXT[protocolName];
                    if (getTextFunction != null)
                    {
                        linkInfo.push(getTextFunction.apply(getTextFunction, paramList));
                    };
                };
                if (htmlMode)
                {
                    text = linkInfo[1];
                    if (PROTOCOL_BOLD[protocolName])
                    {
                        text = HtmlManager.addTag(text, HtmlManager.BOLD);
                    };
                    currentText = leftBlock;
                    currentText = (currentText + HtmlManager.addLink(text, ("event:" + param), null, true));
                    currentText = (currentText + rightBlock);
                    if (textField)
                    {
                        customStyleSheet = ((linkColor) || (hoverColor));
                        if (!(linkColor))
                        {
                            linkColor = XmlConfig.getInstance().getEntry("colors.hyperlink.link");
                            linkColor = linkColor.replace("0x", "#");
                        };
                        if (!(hoverColor))
                        {
                            hoverColor = XmlConfig.getInstance().getEntry("colors.hyperlink.hover");
                            hoverColor = hoverColor.replace("0x", "#");
                        };
                        if (!(customStyleSheet))
                        {
                            if (!(staticStyleSheet))
                            {
                                staticStyleSheet = new StyleSheet();
                            };
                            styleSheet = staticStyleSheet;
                        }
                        else
                        {
                            styleSheet = new StyleSheet();
                        };
                        if (styleSheet.styleNames.length == 0)
                        {
                            styleSheet.setStyle("a:link", {"color":linkColor});
                            styleSheet.setStyle("a:hover", {"color":hoverColor});
                        };
                        textField.styleSheet = styleSheet;
                    };
                }
                else
                {
                    currentText = ((leftBlock + linkInfo[1]) + rightBlock);
                };
            };
            return (currentText);
        }

        public static function registerProtocol(name:String, callBack:Function, textCallBack:Function=null, shiftCallBack:Function=null, useBoldText:Boolean=true, rollOverCallback:Function=null):void
        {
            PROTOCOL[name] = callBack;
            if (textCallBack != null)
            {
                PROTOCOL_TEXT[name] = textCallBack;
            };
            if (shiftCallBack != null)
            {
                PROTOCOL_SHIFT[name] = shiftCallBack;
            };
            if (useBoldText)
            {
                PROTOCOL_BOLD[name] = true;
            };
            if (rollOverCallback != null)
            {
                PROTOCOL_ROLL_OVER[name] = rollOverCallback;
            };
        }

        public static function processClick(event:TextEvent):void
        {
            var shiftCallBack:Function;
            var _local_4:Function;
            lastClickEventFrame = FrameIdManager.frameId;
            StageShareManager.stage.focus = StageShareManager.stage;
            var param:Array = event.text.split(",");
            if (ShortcutsFrame.shiftKey)
            {
                shiftCallBack = PROTOCOL_SHIFT[param[0]];
                if (shiftCallBack == null)
                {
                    KernelEventsManager.getInstance().processCallback(BeriliaHookList.ChatHyperlink, (("{" + param.join(",")) + "}"));
                }
                else
                {
                    param.shift();
                    shiftCallBack.apply(null, param);
                };
            }
            else
            {
                _local_4 = PROTOCOL[param.shift()];
                if (_local_4 != null)
                {
                    _local_4.apply(null, param);
                };
            };
        }

        public static function processRollOver(pEvt:LinkInteractionEvent):void
        {
            if (_rollOverTimer == null)
            {
                _rollOverTimer = new Timer(800, 1);
                _rollOverTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onRollOverTimerComplete);
            }
            else
            {
                _rollOverTimer.reset();
            };
            _rollOverData = pEvt.text;
            _rollOverTimer.start();
        }

        public static function processRollOut(pEvt:LinkInteractionEvent):void
        {
            if (_rollOverTimer != null)
            {
                _rollOverTimer.reset();
            };
            _rollOverData = null;
        }

        private static function onRollOverTimerComplete(pEvt:TimerEvent):void
        {
            if (_rollOverData == null)
            {
                return;
            };
            _rollOverTimer.stop();
            var param:Array = _rollOverData.split(",");
            param[1] = StageShareManager.stage.mouseX;
            var callback:Function = PROTOCOL_ROLL_OVER[param.shift()];
            if (callback != null)
            {
                callback.apply(null, param);
            };
        }


    }
}//package com.ankamagames.berilia.factories

