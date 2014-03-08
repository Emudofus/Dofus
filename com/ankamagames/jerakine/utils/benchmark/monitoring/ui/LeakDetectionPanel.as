package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
   import flash.display.Sprite;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerConst;
   import flash.utils.Dictionary;
   import flash.text.TextField;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.List;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.MonitoredObject;
   import flash.utils.describeType;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerUtils;
   import flash.events.TextEvent;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerEvent;
   
   public class LeakDetectionPanel extends Sprite
   {
      
      public function LeakDetectionPanel() {
         super();
         this._listDataObject = new Dictionary();
         this._dataTf = new TextField();
         this._dataTf.selectable = false;
         this._dataTf.multiline = true;
         this._dataTf.thickness = 200;
         this._dataTf.autoSize = "left";
         this._dataTf.addEventListener(TextEvent.LINK,this.linkHandler);
         addChild(this._dataTf);
         this.drawBG();
      }
      
      private static const WIDTH:int = FpsManagerConst.BOX_WIDTH;
      
      private static const HEIGHT:int = 300;
      
      private var _listDataObject:Dictionary;
      
      private var _dataTf:TextField;
      
      public var dataToDisplay:Vector.<Number>;
      
      private function drawBG() : void {
         graphics.clear();
         graphics.beginFill(FpsManagerConst.BOX_COLOR,0.7);
         graphics.lineStyle(2,FpsManagerConst.BOX_COLOR);
         graphics.drawRoundRect(0,0,WIDTH,this._dataTf.textHeight + 8,8,8);
         graphics.endFill();
      }
      
      public function watchObject(param1:Object, param2:uint, param3:Boolean=false) : void {
         var _loc6_:List = null;
         var _loc7_:List = null;
         var _loc8_:List = null;
         var _loc9_:XML = null;
         var _loc10_:String = null;
         var _loc11_:XML = null;
         var _loc4_:String = getQualifiedClassName(param1).split("::")[1];
         var _loc5_:MonitoredObject = this._listDataObject[_loc4_];
         if(_loc5_ == null)
         {
            if(param3)
            {
               _loc6_ = new List(_loc4_);
               _loc7_ = _loc6_;
               _loc9_ = describeType(param1);
               for each (_loc11_ in _loc9_.extendsClass)
               {
                  _loc10_ = _loc11_.@type.toString().split("::")[1];
                  if(this._listDataObject[_loc10_] != null)
                  {
                     _loc7_.next = this._listDataObject[_loc10_].extendsClass;
                     break;
                  }
                  _loc8_ = new List(_loc10_);
                  _loc7_.next = _loc8_;
                  _loc8_ = _loc7_;
               }
            }
            _loc5_ = new MonitoredObject(_loc4_,param2,_loc6_);
            this._listDataObject[_loc4_] = _loc5_;
            if((param3) && !(_loc6_ == null))
            {
               this.updateParents(_loc6_,_loc5_);
            }
         }
         else
         {
            if(_loc5_.color == 16777215)
            {
               _loc5_.color = param2;
            }
         }
         _loc5_.addNewValue(param1);
      }
      
      private function updateParents(param1:List, param2:Object) : void {
         var _loc3_:List = param1;
         if(_loc3_ != null)
         {
            do
            {
                  if(_loc3_.value != null)
                  {
                     this.updateParent(_loc3_.value.toString(),param2,_loc3_.next);
                  }
               }while((_loc3_ = _loc3_.next) != null);
               
            }
         }
         
         private function updateParent(param1:String, param2:Object, param3:List) : void {
            var _loc4_:MonitoredObject = this._listDataObject[param1];
            if(_loc4_ == null)
            {
               _loc4_ = new MonitoredObject(param1,16777215,param3);
               this._listDataObject[param1] = _loc4_;
            }
            _loc4_.addNewValue(param2);
         }
         
         public function updateData() : void {
            var _loc2_:MonitoredObject = null;
            var _loc1_:* = "";
            for each (_loc2_ in this._listDataObject)
            {
               _loc2_.update();
               _loc1_ = _loc1_ + ("<font face=\'Verdana\' size=\'15\' color=\'#" + _loc2_.color.toString(16) + "\' >");
               if(_loc2_.selected)
               {
                  _loc1_ = _loc1_ + "(*) ";
               }
               _loc1_ = _loc1_ + ("<a href=\'event:" + _loc2_.name + "\'>[" + _loc2_.name + "]</a> : " + FpsManagerUtils.countKeys(_loc2_.list));
               _loc1_ = _loc1_ + "</font>\n";
            }
            this._dataTf.htmlText = _loc1_;
            this._dataTf.width = this._dataTf.textWidth + 10;
            this.drawBG();
         }
         
         private function linkHandler(param1:TextEvent) : void {
            var _loc2_:MonitoredObject = this._listDataObject[param1.text];
            if(_loc2_ == null)
            {
               return;
            }
            var _loc3_:FpsManagerEvent = new FpsManagerEvent("follow");
            _loc3_.data = _loc2_;
            dispatchEvent(_loc3_);
         }
      }
   }
