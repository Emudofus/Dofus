package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
    import flash.display.Sprite;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerConst;
    import flash.utils.Dictionary;
    import flash.text.TextField;
    import __AS3__.vec.Vector;
    import flash.events.TextEvent;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.List;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.MonitoredObject;
    import flash.utils.describeType;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerUtils;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerEvent;

    public class LeakDetectionPanel extends Sprite 
    {

        private static const WIDTH:int = FpsManagerConst.BOX_WIDTH;//250
        private static const HEIGHT:int = 300;

        private var _listDataObject:Dictionary;
        private var _dataTf:TextField;
        public var dataToDisplay:Vector.<Number>;

        public function LeakDetectionPanel()
        {
            this._listDataObject = new Dictionary();
            this._dataTf = new TextField();
            this._dataTf.selectable = false;
            this._dataTf.multiline = true;
            this._dataTf.thickness = 200;
            this._dataTf.autoSize = "left";
            this._dataTf.addEventListener(TextEvent.LINK, this.linkHandler);
            addChild(this._dataTf);
            this.drawBG();
        }

        private function drawBG():void
        {
            graphics.clear();
            graphics.beginFill(FpsManagerConst.BOX_COLOR, 0.7);
            graphics.lineStyle(2, FpsManagerConst.BOX_COLOR);
            graphics.drawRoundRect(0, 0, WIDTH, (this._dataTf.textHeight + 8), 8, 8);
            graphics.endFill();
        }

        public function watchObject(o:Object, pColor:uint, incrementParents:Boolean=false):void
        {
            var list:List;
            var firstList:List;
            var secondList:List;
            var type:XML;
            var c:String;
            var ex:XML;
            var objectName:String = getQualifiedClassName(o).split("::")[1];
            var mObject:MonitoredObject = this._listDataObject[objectName];
            if (mObject == null)
            {
                if (incrementParents)
                {
                    list = new List(objectName);
                    firstList = list;
                    type = describeType(o);
                    for each (ex in type.extendsClass)
                    {
                        c = ex.@type.toString().split("::")[1];
                        if (this._listDataObject[c] != null)
                        {
                            firstList.next = this._listDataObject[c].extendsClass;
                            break;
                        };
                        secondList = new List(c);
                        firstList.next = secondList;
                        secondList = firstList;
                    };
                };
                mObject = new MonitoredObject(objectName, pColor, list);
                this._listDataObject[objectName] = mObject;
                if (((incrementParents) && (!((list == null)))))
                {
                    this.updateParents(list, mObject);
                };
            }
            else
            {
                if (mObject.color == 0xFFFFFF)
                {
                    mObject.color = pColor;
                };
            };
            mObject.addNewValue(o);
        }

        private function updateParents(pList:List, o:Object):void
        {
            var list:List = pList;
            if (list != null)
            {
                do 
                {
                    if (list.value != null)
                    {
                        this.updateParent(list.value.toString(), o, list.next);
                    };
                    list = list.next;
                } while (list != null);
            };
        }

        private function updateParent(pName:String, pValue:Object, pList:List):void
        {
            var mObject:MonitoredObject = this._listDataObject[pName];
            if (mObject == null)
            {
                mObject = new MonitoredObject(pName, 0xFFFFFF, pList);
                this._listDataObject[pName] = mObject;
            };
            mObject.addNewValue(pValue);
        }

        public function updateData():void
        {
            var mo:MonitoredObject;
            var str:String = "";
            for each (mo in this._listDataObject)
            {
                mo.update();
                str = (str + (("<font face='Verdana' size='15' color='#" + mo.color.toString(16)) + "' >"));
                if (mo.selected)
                {
                    str = (str + "(*) ");
                };
                str = (str + ((((("<a href='event:" + mo.name) + "'>[") + mo.name) + "]</a> : ") + FpsManagerUtils.countKeys(mo.list)));
                str = (str + "</font>\n");
            };
            this._dataTf.htmlText = str;
            this._dataTf.width = (this._dataTf.textWidth + 10);
            this.drawBG();
        }

        private function linkHandler(pEvt:TextEvent):void
        {
            var mo:MonitoredObject = this._listDataObject[pEvt.text];
            if (mo == null)
            {
                return;
            };
            var evt:FpsManagerEvent = new FpsManagerEvent("follow");
            evt.data = mo;
            dispatchEvent(evt);
        }


    }
}//package com.ankamagames.jerakine.utils.benchmark.monitoring.ui

