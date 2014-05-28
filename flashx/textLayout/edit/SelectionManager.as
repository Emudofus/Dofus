package flashx.textLayout.edit
{
   import flashx.textLayout.elements.TextFlow;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.compose.TextFlowLine;
   import flash.text.engine.TextLine;
   import flash.geom.Rectangle;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.formats.Direction;
   import flash.display.DisplayObject;
   import flashx.textLayout.container.ColumnState;
   import flash.text.engine.TextLineValidity;
   import flash.geom.Point;
   import flash.text.engine.TextRotation;
   import flash.display.Stage;
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.elements.ParagraphElement;
   import flashx.textLayout.formats.ITextLayoutFormat;
   import flash.ui.MouseCursor;
   import flash.display.InteractiveObject;
   import flashx.textLayout.utils.NavigationUtil;
   import flash.ui.Mouse;
   import flashx.textLayout.compose.IFlowComposer;
   import flashx.textLayout.events.SelectionEvent;
   import flash.events.MouseEvent;
   import flash.events.FocusEvent;
   import flash.events.Event;
   import flashx.textLayout.operations.FlowOperation;
   import flashx.textLayout.events.FlowOperationEvent;
   import flashx.textLayout.operations.CopyOperation;
   import flash.errors.IllegalOperationError;
   import flashx.textLayout.elements.GlobalSettings;
   import flash.utils.getQualifiedClassName;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import flash.events.TextEvent;
   import flash.events.IMEEvent;
   import flash.events.ContextMenuEvent;
   import flash.ui.ContextMenu;
   import flash.desktop.Clipboard;
   import flash.desktop.ClipboardFormats;
   import flashx.textLayout.formats.TextLayoutFormat;
   import flashx.textLayout.elements.TextRange;
   
   use namespace tlf_internal;
   
   public class SelectionManager extends Object implements ISelectionManager
   {
      
      public function SelectionManager() {
         this.marks = [];
         super();
         this._textFlow = null;
         this.anchorMark = this.createMark();
         this.activeMark = this.createMark();
         this._pointFormat = null;
         this._isActive = false;
      }
      
      private static function computeSelectionIndexInContainer(param1:TextFlow, param2:ContainerController, param3:Number, param4:Number) : int {
         var _loc16_:TextFlowLine = null;
         var _loc17_:TextLine = null;
         var _loc25_:Rectangle = null;
         var _loc26_:* = NaN;
         var _loc27_:* = NaN;
         var _loc28_:* = false;
         var _loc29_:* = NaN;
         var _loc30_:* = false;
         var _loc31_:* = 0;
         var _loc32_:String = null;
         var _loc5_:* = -1;
         var _loc6_:int = param2.absoluteStart;
         var _loc7_:int = param2.textLength;
         var _loc8_:String = param1.computedFormat.blockProgression;
         var _loc9_:* = _loc8_ == BlockProgression.RL;
         var _loc10_:* = param1.computedFormat.direction == Direction.RTL;
         var _loc11_:Number = _loc9_?param3:param4;
         var _loc12_:int = locateNearestColumn(param2,param3,param4,param1.computedFormat.blockProgression,param1.computedFormat.direction);
         var _loc13_:Rectangle = null;
         var _loc14_:* = -1;
         var _loc15_:* = -1;
         var _loc18_:int = param1.flowComposer.numLines-1;
         while(_loc18_ >= 0)
         {
            _loc16_ = param1.flowComposer.getLineAt(_loc18_);
            if(!(_loc16_.controller == param2) || !(_loc16_.columnIndex == _loc12_))
            {
               if(_loc15_ != -1)
               {
                  _loc5_ = _loc18_ + 1;
                  break;
               }
            }
            else
            {
               if(!(_loc16_.absoluteStart < _loc6_ || _loc16_.absoluteStart >= _loc6_ + _loc7_))
               {
                  _loc17_ = _loc16_.getTextLine();
                  if(!(_loc17_ == null || _loc17_.parent == null))
                  {
                     if(_loc15_ == -1)
                     {
                        _loc15_ = _loc18_;
                     }
                     _loc25_ = _loc17_.getBounds(DisplayObject(param2.container));
                     _loc26_ = _loc9_?_loc25_.left:_loc25_.bottom;
                     _loc27_ = -1;
                     if(_loc13_)
                     {
                        _loc29_ = _loc9_?_loc13_.right:_loc13_.top;
                        _loc27_ = (_loc26_ + _loc29_) / 2;
                     }
                     _loc28_ = _loc9_?_loc26_ > _loc11_:_loc26_ < _loc11_;
                     if((_loc28_) || _loc18_ == 0)
                     {
                        _loc30_ = !(_loc27_ == -1) && (_loc9_?_loc11_ < _loc27_:_loc11_ > _loc27_);
                        _loc5_ = (_loc30_) && !(_loc18_ == _loc15_)?_loc18_ + 1:_loc18_;
                        break;
                     }
                     _loc13_ = _loc25_;
                     _loc14_ = _loc18_;
                  }
               }
            }
            _loc18_--;
         }
         if(_loc5_ == -1)
         {
            _loc5_ = _loc14_;
            if(_loc5_ == -1)
            {
               return -1;
            }
         }
         var _loc19_:TextFlowLine = param1.flowComposer.getLineAt(_loc5_);
         var _loc20_:TextLine = _loc19_.getTextLine(true);
         var param3:Number = param3 - _loc20_.x;
         var param4:Number = param4 - _loc20_.y;
         var _loc21_:* = false;
         var _loc22_:* = -1;
         if(_loc10_)
         {
            _loc22_ = _loc20_.atomCount-1;
         }
         else
         {
            if(_loc19_.absoluteStart + _loc19_.textLength >= _loc19_.paragraph.getAbsoluteStart() + _loc19_.paragraph.textLength)
            {
               if(_loc20_.atomCount > 1)
               {
                  _loc22_ = _loc20_.atomCount - 2;
               }
            }
            else
            {
               _loc31_ = _loc19_.absoluteStart + _loc19_.textLength-1;
               _loc32_ = _loc20_.textBlock.content.rawText.charAt(_loc31_);
               if(_loc32_ == " ")
               {
                  if(_loc20_.atomCount > 1)
                  {
                     _loc22_ = _loc20_.atomCount - 2;
                  }
               }
               else
               {
                  _loc21_ = true;
                  if(_loc20_.atomCount > 0)
                  {
                     _loc22_ = _loc20_.atomCount-1;
                  }
               }
            }
         }
         var _loc23_:Rectangle = _loc22_ > 0?_loc20_.getAtomBounds(_loc22_):new Rectangle(0,0,0,0);
         if(!_loc9_)
         {
            if(param3 < 0)
            {
               param3 = 0;
            }
            else
            {
               if(param3 > _loc23_.x + _loc23_.width)
               {
                  if(_loc21_)
                  {
                     return _loc19_.absoluteStart + _loc19_.textLength-1;
                  }
                  if(_loc23_.x + _loc23_.width > 0)
                  {
                     param3 = _loc23_.x + _loc23_.width;
                  }
               }
            }
         }
         else
         {
            if(param4 < 0)
            {
               param4 = 0;
            }
            else
            {
               if(param4 > _loc23_.y + _loc23_.height)
               {
                  if(_loc21_)
                  {
                     return _loc19_.absoluteStart + _loc19_.textLength-1;
                  }
                  if(_loc23_.y + _loc23_.height > 0)
                  {
                     param4 = _loc23_.y + _loc23_.height;
                  }
               }
            }
         }
         var _loc24_:int = computeSelectionIndexInLine(param1,_loc20_,param3,param4);
         return _loc24_ != -1?_loc24_:_loc6_ + _loc7_;
      }
      
      private static function locateNearestColumn(param1:ContainerController, param2:Number, param3:Number, param4:String, param5:String) : int {
         var _loc8_:Rectangle = null;
         var _loc9_:Rectangle = null;
         var _loc6_:* = 0;
         var _loc7_:ColumnState = param1.columnState;
         while(_loc6_ < _loc7_.columnCount-1)
         {
            _loc8_ = _loc7_.getColumnAt(_loc6_);
            _loc9_ = _loc7_.getColumnAt(_loc6_ + 1);
            if(_loc8_.contains(param2,param3))
            {
               break;
            }
            if(_loc9_.contains(param2,param3))
            {
               _loc6_++;
               break;
            }
            if(param4 == BlockProgression.RL)
            {
               if(param3 < _loc8_.top || param3 < _loc9_.top && Math.abs(_loc8_.bottom - param3) <= Math.abs(_loc9_.top - param3))
               {
                  break;
               }
               if(param3 > _loc9_.top)
               {
                  _loc6_++;
                  break;
               }
            }
            else
            {
               if(param5 == Direction.LTR)
               {
                  if(param2 < _loc8_.left || param2 < _loc9_.left && Math.abs(_loc8_.right - param2) <= Math.abs(_loc9_.left - param2))
                  {
                     break;
                  }
                  if(param2 < _loc9_.left)
                  {
                     _loc6_++;
                     break;
                  }
               }
               else
               {
                  if(param2 > _loc8_.right || param2 > _loc9_.right && Math.abs(_loc8_.left - param2) <= Math.abs(_loc9_.right - param2))
                  {
                     break;
                  }
                  if(param2 > _loc9_.right)
                  {
                     _loc6_++;
                     break;
                  }
               }
            }
            _loc6_++;
         }
         return _loc6_;
      }
      
      private static function computeSelectionIndexInLine(param1:TextFlow, param2:TextLine, param3:Number, param4:Number) : int {
         var _loc12_:* = 0;
         if(!(param2.userData is TextFlowLine))
         {
            return -1;
         }
         var _loc5_:TextFlowLine = TextFlowLine(param2.userData);
         if(_loc5_.validity == TextLineValidity.INVALID)
         {
            return -1;
         }
         var param2:TextLine = _loc5_.getTextLine(true);
         var _loc6_:* = param1.computedFormat.blockProgression == BlockProgression.RL;
         var _loc7_:Number = _loc6_?param3:param4;
         var _loc8_:Point = new Point();
         _loc8_.x = param3;
         _loc8_.y = param4;
         _loc8_ = param2.localToGlobal(_loc8_);
         var _loc9_:int = param2.getAtomIndexAtPoint(_loc8_.x,_loc8_.y);
         if(_loc9_ == -1)
         {
            _loc8_.x = param3;
            _loc8_.y = param4;
            if(_loc8_.x < 0 || (_loc6_) && _loc7_ > param2.ascent)
            {
               _loc8_.x = 0;
            }
            if(_loc8_.y < 0 || !_loc6_ && _loc7_ > param2.descent)
            {
               _loc8_.y = 0;
            }
            _loc8_ = param2.localToGlobal(_loc8_);
            _loc9_ = param2.getAtomIndexAtPoint(_loc8_.x,_loc8_.y);
         }
         if(_loc9_ == -1)
         {
            _loc8_.x = param3;
            _loc8_.y = param4;
            _loc8_ = param2.localToGlobal(_loc8_);
            if(param2.parent)
            {
               _loc8_ = param2.parent.globalToLocal(_loc8_);
            }
            if(!_loc6_)
            {
               return _loc8_.x <= param2.x?_loc5_.absoluteStart:_loc5_.absoluteStart + _loc5_.textLength-1;
            }
            return _loc8_.y <= param2.y?_loc5_.absoluteStart:_loc5_.absoluteStart + _loc5_.textLength-1;
         }
         var _loc10_:Rectangle = param2.getAtomBounds(_loc9_);
         var _loc11_:* = false;
         if(_loc10_)
         {
            if((_loc6_) && !(param2.getAtomTextRotation(_loc9_) == TextRotation.ROTATE_0))
            {
               _loc11_ = param4 > _loc10_.y + _loc10_.height / 2;
            }
            else
            {
               _loc11_ = param3 > _loc10_.x + _loc10_.width / 2;
            }
         }
         if(param2.getAtomBidiLevel(_loc9_) % 2 != 0)
         {
            _loc12_ = _loc11_?param2.getAtomTextBlockBeginIndex(_loc9_):param2.getAtomTextBlockEndIndex(_loc9_);
         }
         else
         {
            _loc12_ = _loc11_?param2.getAtomTextBlockEndIndex(_loc9_):param2.getAtomTextBlockBeginIndex(_loc9_);
         }
         return _loc5_.paragraph.getAbsoluteStart() + _loc12_;
      }
      
      private static function checkForDisplayed(param1:DisplayObject) : Boolean {
         var container:DisplayObject = param1;
         try
         {
            while(container)
            {
               if(!container.visible)
               {
                  return false;
               }
               container = container.parent;
               if(container is Stage)
               {
                  return true;
               }
            }
         }
         catch(e:Error)
         {
            return true;
         }
         return false;
      }
      
      tlf_internal  static function computeSelectionIndex(param1:TextFlow, param2:Object, param3:Object, param4:Number, param5:Number) : int {
         var _loc7_:Point = null;
         var _loc9_:TextFlowLine = null;
         var _loc10_:ParagraphElement = null;
         var _loc11_:ContainerController = null;
         var _loc12_:* = 0;
         var _loc13_:ContainerController = null;
         var _loc14_:ContainerController = null;
         var _loc15_:* = NaN;
         var _loc16_:* = NaN;
         var _loc17_:* = NaN;
         var _loc18_:* = 0;
         var _loc19_:ContainerController = null;
         var _loc20_:Rectangle = null;
         var _loc21_:* = NaN;
         var _loc22_:* = NaN;
         var _loc23_:* = NaN;
         var _loc24_:* = NaN;
         var _loc25_:* = NaN;
         var _loc26_:* = NaN;
         var _loc27_:* = NaN;
         var _loc6_:* = 0;
         var _loc8_:* = false;
         if(param2 is TextLine)
         {
            _loc9_ = TextLine(param2).userData as TextFlowLine;
            if(_loc9_)
            {
               _loc10_ = _loc9_.paragraph;
               if(_loc10_.getTextFlow() == param1)
               {
                  _loc8_ = true;
               }
            }
         }
         if(_loc8_)
         {
            _loc6_ = computeSelectionIndexInLine(param1,TextLine(param2),param4,param5);
         }
         else
         {
            _loc12_ = 0;
            while(_loc12_ < param1.flowComposer.numControllers)
            {
               _loc13_ = param1.flowComposer.getControllerAt(_loc12_);
               if(_loc13_.container == param2 || _loc13_.container == param3)
               {
                  _loc11_ = _loc13_;
                  break;
               }
               _loc12_++;
            }
            if(_loc11_)
            {
               if(param2 != _loc11_.container)
               {
                  _loc7_ = DisplayObject(param2).localToGlobal(new Point(param4,param5));
                  _loc7_ = DisplayObject(_loc11_.container).globalToLocal(_loc7_);
                  param4 = _loc7_.x;
                  param5 = _loc7_.y;
               }
               _loc6_ = computeSelectionIndexInContainer(param1,_loc11_,param4,param5);
            }
            else
            {
               _loc14_ = null;
               _loc17_ = Number.MAX_VALUE;
               _loc18_ = 0;
               while(_loc18_ < param1.flowComposer.numControllers)
               {
                  _loc19_ = param1.flowComposer.getControllerAt(_loc18_);
                  if(checkForDisplayed(_loc19_.container as DisplayObject))
                  {
                     _loc20_ = _loc19_.getContentBounds();
                     _loc21_ = isNaN(_loc19_.compositionWidth)?_loc19_.getTotalPaddingLeft() + _loc20_.width:_loc19_.compositionWidth;
                     _loc22_ = isNaN(_loc19_.compositionHeight)?_loc19_.getTotalPaddingTop() + _loc20_.height:_loc19_.compositionHeight;
                     _loc7_ = DisplayObject(param2).localToGlobal(new Point(param4,param5));
                     _loc7_ = DisplayObject(_loc19_.container).globalToLocal(_loc7_);
                     _loc23_ = 0;
                     _loc24_ = 0;
                     if(_loc19_.hasScrollRect)
                     {
                        _loc7_.x = _loc7_.x - (_loc23_ = _loc19_.container.scrollRect.x);
                        _loc7_.y = _loc7_.y - (_loc24_ = _loc19_.container.scrollRect.y);
                     }
                     if(_loc7_.x >= 0 && _loc7_.x <= _loc21_ && _loc7_.y >= 0 && _loc7_.y <= _loc22_)
                     {
                        _loc14_ = _loc19_;
                        _loc15_ = _loc7_.x + _loc23_;
                        _loc16_ = _loc7_.y + _loc24_;
                        break;
                     }
                     _loc25_ = 0;
                     _loc26_ = 0;
                     if(_loc7_.x < 0)
                     {
                        _loc25_ = _loc7_.x;
                        if(_loc7_.y < 0)
                        {
                           _loc26_ = _loc7_.y;
                        }
                        else
                        {
                           if(_loc7_.y > _loc22_)
                           {
                              _loc26_ = _loc7_.y - _loc22_;
                           }
                        }
                     }
                     else
                     {
                        if(_loc7_.x > _loc21_)
                        {
                           _loc25_ = _loc7_.x - _loc21_;
                           if(_loc7_.y < 0)
                           {
                              _loc26_ = _loc7_.y;
                           }
                           else
                           {
                              if(_loc7_.y > _loc22_)
                              {
                                 _loc26_ = _loc7_.y - _loc22_;
                              }
                           }
                        }
                        else
                        {
                           if(_loc7_.y < 0)
                           {
                              _loc26_ = -_loc7_.y;
                           }
                           else
                           {
                              _loc26_ = _loc7_.y - _loc22_;
                           }
                        }
                     }
                     _loc27_ = _loc25_ * _loc25_ + _loc26_ * _loc26_;
                     if(_loc27_ <= _loc17_)
                     {
                        _loc17_ = _loc27_;
                        _loc14_ = _loc19_;
                        _loc15_ = _loc7_.x + _loc23_;
                        _loc16_ = _loc7_.y + _loc24_;
                     }
                  }
                  _loc18_++;
               }
               _loc6_ = _loc14_?computeSelectionIndexInContainer(param1,_loc14_,_loc15_,_loc16_):-1;
            }
         }
         if(_loc6_ >= param1.textLength)
         {
            _loc6_ = param1.textLength-1;
         }
         return _loc6_;
      }
      
      private var _focusedSelectionFormat:SelectionFormat;
      
      private var _unfocusedSelectionFormat:SelectionFormat;
      
      private var _inactiveSelectionFormat:SelectionFormat;
      
      private var _selFormatState:String = "unfocused";
      
      private var _isActive:Boolean;
      
      private var _textFlow:TextFlow;
      
      private var anchorMark:Mark;
      
      private var activeMark:Mark;
      
      private var _pointFormat:ITextLayoutFormat;
      
      protected function get pointFormat() : ITextLayoutFormat {
         return this._pointFormat;
      }
      
      protected var ignoreNextTextEvent:Boolean = false;
      
      protected var allowOperationMerge:Boolean = false;
      
      private var _mouseOverSelectionArea:Boolean = false;
      
      public function getSelectionState() : SelectionState {
         return new SelectionState(this._textFlow,this.anchorMark.position,this.activeMark.position,this.pointFormat);
      }
      
      public function setSelectionState(param1:SelectionState) : void {
         this.internalSetSelection(param1.textFlow,param1.anchorPosition,param1.activePosition,param1.pointFormat);
      }
      
      public function hasSelection() : Boolean {
         return !(this.anchorMark.position == -1);
      }
      
      public function isRangeSelection() : Boolean {
         return !(this.anchorMark.position == -1) && !(this.anchorMark.position == this.activeMark.position);
      }
      
      public function get textFlow() : TextFlow {
         return this._textFlow;
      }
      
      public function set textFlow(param1:TextFlow) : void {
         if(this._textFlow != param1)
         {
            if(this._textFlow)
            {
               this.flushPendingOperations();
            }
            this.clear();
            if(!param1)
            {
               this.setMouseCursor(MouseCursor.AUTO);
            }
            this._textFlow = param1;
            if((this._textFlow) && !(this._textFlow.interactionManager == this))
            {
               this._textFlow.interactionManager = this;
            }
         }
      }
      
      public function get editingMode() : String {
         return EditingMode.READ_SELECT;
      }
      
      public function get windowActive() : Boolean {
         return !(this._selFormatState == SelectionFormatState.INACTIVE);
      }
      
      public function get focused() : Boolean {
         return this._selFormatState == SelectionFormatState.FOCUSED;
      }
      
      public function get currentSelectionFormat() : SelectionFormat {
         if(this._selFormatState == SelectionFormatState.UNFOCUSED)
         {
            return this.unfocusedSelectionFormat;
         }
         if(this._selFormatState == SelectionFormatState.INACTIVE)
         {
            return this.inactiveSelectionFormat;
         }
         return this.focusedSelectionFormat;
      }
      
      public function set focusedSelectionFormat(param1:SelectionFormat) : void {
         this._focusedSelectionFormat = param1;
         if(this._selFormatState == SelectionFormatState.FOCUSED)
         {
            this.refreshSelection();
         }
      }
      
      public function get focusedSelectionFormat() : SelectionFormat {
         return this._focusedSelectionFormat?this._focusedSelectionFormat:this._textFlow?this._textFlow.configuration.focusedSelectionFormat:null;
      }
      
      public function set unfocusedSelectionFormat(param1:SelectionFormat) : void {
         this._unfocusedSelectionFormat = param1;
         if(this._selFormatState == SelectionFormatState.UNFOCUSED)
         {
            this.refreshSelection();
         }
      }
      
      public function get unfocusedSelectionFormat() : SelectionFormat {
         return this._unfocusedSelectionFormat?this._unfocusedSelectionFormat:this._textFlow?this._textFlow.configuration.unfocusedSelectionFormat:null;
      }
      
      public function set inactiveSelectionFormat(param1:SelectionFormat) : void {
         this._inactiveSelectionFormat = param1;
         if(this._selFormatState == SelectionFormatState.INACTIVE)
         {
            this.refreshSelection();
         }
      }
      
      public function get inactiveSelectionFormat() : SelectionFormat {
         return this._inactiveSelectionFormat?this._inactiveSelectionFormat:this._textFlow?this._textFlow.configuration.inactiveSelectionFormat:null;
      }
      
      tlf_internal function get selectionFormatState() : String {
         return this._selFormatState;
      }
      
      tlf_internal function setSelectionFormatState(param1:String) : void {
         var _loc2_:SelectionFormat = null;
         var _loc3_:SelectionFormat = null;
         if(param1 != this._selFormatState)
         {
            _loc2_ = this.currentSelectionFormat;
            this._selFormatState = param1;
            _loc3_ = this.currentSelectionFormat;
            if(!_loc3_.equals(_loc2_))
            {
               this.refreshSelection();
            }
         }
      }
      
      tlf_internal function cloneSelectionFormatState(param1:ISelectionManager) : void {
         var _loc2_:SelectionManager = param1 as SelectionManager;
         if(_loc2_)
         {
            this._isActive = _loc2_._isActive;
            this._mouseOverSelectionArea = _loc2_._mouseOverSelectionArea;
            this.setSelectionFormatState(_loc2_.selectionFormatState);
         }
      }
      
      private function selectionPoint(param1:Object, param2:InteractiveObject, param3:Number, param4:Number, param5:Boolean=false) : SelectionState {
         if(!this._textFlow)
         {
            return null;
         }
         if(!this.hasSelection())
         {
            param5 = false;
         }
         var _loc6_:int = this.anchorMark.position;
         var _loc7_:int = this.activeMark.position;
         _loc7_ = computeSelectionIndex(this._textFlow,param2,param1,param3,param4);
         if(_loc7_ == -1)
         {
            return null;
         }
         _loc7_ = Math.min(_loc7_,this._textFlow.textLength-1);
         if(!param5)
         {
            _loc6_ = _loc7_;
         }
         if(_loc6_ == _loc7_)
         {
            _loc6_ = NavigationUtil.updateStartIfInReadOnlyElement(this._textFlow,_loc6_);
            _loc7_ = NavigationUtil.updateEndIfInReadOnlyElement(this._textFlow,_loc7_);
         }
         else
         {
            _loc7_ = NavigationUtil.updateEndIfInReadOnlyElement(this._textFlow,_loc7_);
         }
         return new SelectionState(this.textFlow,_loc6_,_loc7_);
      }
      
      public function setFocus() : void {
         if(!this._textFlow)
         {
            return;
         }
         if(this._textFlow.flowComposer)
         {
            this._textFlow.flowComposer.setFocus(this.activePosition,false);
         }
         this.setSelectionFormatState(SelectionFormatState.FOCUSED);
      }
      
      protected function setMouseCursor(param1:String) : void {
         Mouse.cursor = param1;
      }
      
      public function get anchorPosition() : int {
         return this.anchorMark.position;
      }
      
      public function get activePosition() : int {
         return this.activeMark.position;
      }
      
      public function get absoluteStart() : int {
         return this.anchorMark.position < this.activeMark.position?this.anchorMark.position:this.activeMark.position;
      }
      
      public function get absoluteEnd() : int {
         return this.anchorMark.position > this.activeMark.position?this.anchorMark.position:this.activeMark.position;
      }
      
      public function selectAll() : void {
         this.selectRange(0,int.MAX_VALUE);
      }
      
      public function selectRange(param1:int, param2:int) : void {
         this.flushPendingOperations();
         if(!(param1 == this.anchorMark.position) || !(param2 == this.activeMark.position))
         {
            this.clearSelectionShapes();
            this.internalSetSelection(this._textFlow,param1,param2);
            this.selectionChanged();
            this.allowOperationMerge = false;
         }
      }
      
      private function internalSetSelection(param1:TextFlow, param2:int, param3:int, param4:ITextLayoutFormat=null) : void {
         this._textFlow = param1;
         if(param2 < 0 || param3 < 0)
         {
            param2 = -1;
            param3 = -1;
         }
         var _loc5_:int = this._textFlow.textLength > 0?this._textFlow.textLength-1:0;
         if(!(param2 == -1) && !(param3 == -1))
         {
            if(param2 > _loc5_)
            {
               param2 = _loc5_;
            }
            if(param3 > _loc5_)
            {
               param3 = _loc5_;
            }
         }
         this._pointFormat = param4;
         this.anchorMark.position = param2;
         this.activeMark.position = param3;
      }
      
      private function clear() : void {
         if(this.hasSelection())
         {
            this.flushPendingOperations();
            this.clearSelectionShapes();
            this.internalSetSelection(this._textFlow,-1,-1);
            this.selectionChanged();
            this.allowOperationMerge = false;
         }
      }
      
      private function addSelectionShapes() : void {
         var _loc1_:* = 0;
         if(this._textFlow.flowComposer)
         {
            this.internalSetSelection(this._textFlow,this.anchorMark.position,this.activeMark.position,this._pointFormat);
            if((this.currentSelectionFormat) && (this.absoluteStart == this.absoluteEnd && !(this.currentSelectionFormat.pointAlpha == 0) || !(this.absoluteStart == this.absoluteEnd) && !(this.currentSelectionFormat.rangeAlpha == 0)))
            {
               _loc1_ = 0;
               while(_loc1_ < this._textFlow.flowComposer.numControllers)
               {
                  this._textFlow.flowComposer.getControllerAt(_loc1_++).addSelectionShapes(this.currentSelectionFormat,this.absoluteStart,this.absoluteEnd);
               }
            }
         }
      }
      
      private function clearSelectionShapes() : void {
         var _loc2_:* = 0;
         var _loc1_:IFlowComposer = this._textFlow?this._textFlow.flowComposer:null;
         if(_loc1_)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_.numControllers)
            {
               _loc1_.getControllerAt(_loc2_++).clearSelectionShapes();
            }
         }
      }
      
      public function refreshSelection() : void {
         if(this.hasSelection())
         {
            this.clearSelectionShapes();
            this.addSelectionShapes();
         }
      }
      
      tlf_internal function selectionChanged(param1:Boolean=true, param2:Boolean=true) : void {
         if(param2)
         {
            this._pointFormat = null;
         }
         if((param1) && (this._textFlow))
         {
            this.textFlow.dispatchEvent(new SelectionEvent(SelectionEvent.SELECTION_CHANGE,false,false,this.hasSelection()?this.getSelectionState():null));
         }
      }
      
      tlf_internal function setNewSelectionPoint(param1:Object, param2:InteractiveObject, param3:Number, param4:Number, param5:Boolean=false) : Boolean {
         var _loc6_:SelectionState = this.selectionPoint(param1,param2,param3,param4,param5);
         if(_loc6_ == null)
         {
            return false;
         }
         if(!(_loc6_.anchorPosition == this.anchorMark.position) || !(_loc6_.activePosition == this.activeMark.position))
         {
            this.selectRange(_loc6_.anchorPosition,_loc6_.activePosition);
            return true;
         }
         return false;
      }
      
      public function mouseDownHandler(param1:MouseEvent) : void {
         this.handleMouseEventForSelection(param1,param1.shiftKey);
      }
      
      public function mouseMoveHandler(param1:MouseEvent) : void {
         var _loc2_:String = this.textFlow.computedFormat.blockProgression;
         if(_loc2_ != BlockProgression.RL)
         {
            this.setMouseCursor(MouseCursor.IBEAM);
         }
         if(param1.buttonDown)
         {
            this.handleMouseEventForSelection(param1,true);
         }
      }
      
      tlf_internal function handleMouseEventForSelection(param1:MouseEvent, param2:Boolean) : void {
         var _loc3_:Boolean = this.hasSelection();
         if(this.setNewSelectionPoint(param1.currentTarget,param1.target as InteractiveObject,param1.localX,param1.localY,(_loc3_) && (param2)))
         {
            if(_loc3_)
            {
               this.clearSelectionShapes();
            }
            if(this.hasSelection())
            {
               this.addSelectionShapes();
            }
         }
         this.allowOperationMerge = false;
      }
      
      public function mouseUpHandler(param1:MouseEvent) : void {
         if(!this._mouseOverSelectionArea)
         {
            this.setMouseCursor(MouseCursor.AUTO);
         }
      }
      
      private function atBeginningWordPos(param1:ParagraphElement, param2:int) : Boolean {
         if(param2 == 0)
         {
            return true;
         }
         var _loc3_:int = param1.findNextWordBoundary(param2);
         _loc3_ = param1.findPreviousWordBoundary(_loc3_);
         return param2 == _loc3_;
      }
      
      public function mouseDoubleClickHandler(param1:MouseEvent) : void {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:ParagraphElement = null;
         var _loc7_:* = 0;
         if(!this.hasSelection())
         {
            return;
         }
         var _loc2_:ParagraphElement = this._textFlow.findAbsoluteParagraph(this.activeMark.position);
         var _loc3_:int = _loc2_.getAbsoluteStart();
         if(this.anchorMark.position <= this.activeMark.position)
         {
            _loc4_ = _loc2_.findNextWordBoundary(this.activeMark.position - _loc3_) + _loc3_;
         }
         else
         {
            _loc4_ = _loc2_.findPreviousWordBoundary(this.activeMark.position - _loc3_) + _loc3_;
         }
         if(_loc4_ == _loc3_ + _loc2_.textLength)
         {
            _loc4_--;
         }
         if(param1.shiftKey)
         {
            _loc5_ = this.anchorMark.position;
         }
         else
         {
            _loc6_ = this._textFlow.findAbsoluteParagraph(this.anchorMark.position);
            _loc7_ = _loc6_.getAbsoluteStart();
            if(this.atBeginningWordPos(_loc6_,this.anchorMark.position - _loc7_))
            {
               _loc5_ = this.anchorMark.position;
            }
            else
            {
               if(this.anchorMark.position <= this.activeMark.position)
               {
                  _loc5_ = _loc6_.findPreviousWordBoundary(this.anchorMark.position - _loc7_) + _loc7_;
               }
               else
               {
                  _loc5_ = _loc6_.findNextWordBoundary(this.anchorMark.position - _loc7_) + _loc7_;
               }
               if(_loc5_ == _loc7_ + _loc6_.textLength)
               {
                  _loc5_--;
               }
            }
         }
         if(!(_loc5_ == this.anchorMark.position) || !(_loc4_ == this.activeMark.position))
         {
            this.internalSetSelection(this._textFlow,_loc5_,_loc4_,null);
            this.selectionChanged();
            this.clearSelectionShapes();
            if(this.hasSelection())
            {
               this.addSelectionShapes();
            }
         }
         this.allowOperationMerge = false;
      }
      
      public function mouseOverHandler(param1:MouseEvent) : void {
         this._mouseOverSelectionArea = true;
         var _loc2_:String = this.textFlow.computedFormat.blockProgression;
         if(_loc2_ != BlockProgression.RL)
         {
            this.setMouseCursor(MouseCursor.IBEAM);
         }
         else
         {
            this.setMouseCursor(MouseCursor.AUTO);
         }
      }
      
      public function mouseOutHandler(param1:MouseEvent) : void {
         this._mouseOverSelectionArea = false;
         this.setMouseCursor(MouseCursor.AUTO);
      }
      
      public function focusInHandler(param1:FocusEvent) : void {
         this._isActive = true;
         this.setSelectionFormatState(SelectionFormatState.FOCUSED);
      }
      
      public function focusOutHandler(param1:FocusEvent) : void {
         if(this._isActive)
         {
            this.setSelectionFormatState(SelectionFormatState.UNFOCUSED);
         }
      }
      
      public function activateHandler(param1:Event) : void {
         if(!this._isActive)
         {
            this._isActive = true;
            this.setSelectionFormatState(SelectionFormatState.UNFOCUSED);
         }
      }
      
      public function deactivateHandler(param1:Event) : void {
         if(this._isActive)
         {
            this._isActive = false;
            this.setSelectionFormatState(SelectionFormatState.INACTIVE);
         }
      }
      
      public function doOperation(param1:FlowOperation) : void {
         var opError:Error = null;
         var op:FlowOperation = param1;
         var opEvent:FlowOperationEvent = new FlowOperationEvent(FlowOperationEvent.FLOW_OPERATION_BEGIN,false,true,op,0,null);
         this.textFlow.dispatchEvent(opEvent);
         if(!opEvent.isDefaultPrevented())
         {
            op = opEvent.operation;
            if(!(op is CopyOperation))
            {
               throw new IllegalOperationError(GlobalSettings.resourceStringFunction("illegalOperation",[getQualifiedClassName(op)]));
            }
            else
            {
               opError = null;
               try
               {
                  op.doOperation();
               }
               catch(e:Error)
               {
                  opError = e;
               }
               opEvent = new FlowOperationEvent(FlowOperationEvent.FLOW_OPERATION_END,false,true,op,0,opError);
               this.textFlow.dispatchEvent(opEvent);
               opError = opEvent.isDefaultPrevented()?null:opEvent.error;
               if(opError)
               {
                  throw opError;
               }
               else
               {
                  this.textFlow.dispatchEvent(new FlowOperationEvent(FlowOperationEvent.FLOW_OPERATION_COMPLETE,false,false,op,0,null));
               }
            }
         }
      }
      
      public function editHandler(param1:Event) : void {
         switch(param1.type)
         {
            case Event.COPY:
               this.flushPendingOperations();
               this.doOperation(new CopyOperation(this.getSelectionState()));
               break;
            case Event.SELECT_ALL:
               this.flushPendingOperations();
               this.selectAll();
               this.refreshSelection();
               break;
         }
      }
      
      private function handleLeftArrow(param1:KeyboardEvent) : SelectionState {
         var _loc2_:SelectionState = this.getSelectionState();
         if(this._textFlow.computedFormat.blockProgression != BlockProgression.RL)
         {
            if(this._textFlow.computedFormat.direction == Direction.LTR)
            {
               if((param1.ctrlKey) || (param1.altKey))
               {
                  NavigationUtil.previousWord(_loc2_,param1.shiftKey);
               }
               else
               {
                  NavigationUtil.previousCharacter(_loc2_,param1.shiftKey);
               }
            }
            else
            {
               if((param1.ctrlKey) || (param1.altKey))
               {
                  NavigationUtil.nextWord(_loc2_,param1.shiftKey);
               }
               else
               {
                  NavigationUtil.nextCharacter(_loc2_,param1.shiftKey);
               }
            }
         }
         else
         {
            if(param1.altKey)
            {
               NavigationUtil.endOfParagraph(_loc2_,param1.shiftKey);
            }
            else
            {
               if(param1.ctrlKey)
               {
                  NavigationUtil.endOfDocument(_loc2_,param1.shiftKey);
               }
               else
               {
                  NavigationUtil.nextLine(_loc2_,param1.shiftKey);
               }
            }
         }
         return _loc2_;
      }
      
      private function handleUpArrow(param1:KeyboardEvent) : SelectionState {
         var _loc2_:SelectionState = this.getSelectionState();
         if(this._textFlow.computedFormat.blockProgression != BlockProgression.RL)
         {
            if(param1.altKey)
            {
               NavigationUtil.startOfParagraph(_loc2_,param1.shiftKey);
            }
            else
            {
               if(param1.ctrlKey)
               {
                  NavigationUtil.startOfDocument(_loc2_,param1.shiftKey);
               }
               else
               {
                  NavigationUtil.previousLine(_loc2_,param1.shiftKey);
               }
            }
         }
         else
         {
            if(this._textFlow.computedFormat.direction == Direction.LTR)
            {
               if((param1.ctrlKey) || (param1.altKey))
               {
                  NavigationUtil.previousWord(_loc2_,param1.shiftKey);
               }
               else
               {
                  NavigationUtil.previousCharacter(_loc2_,param1.shiftKey);
               }
            }
            else
            {
               if((param1.ctrlKey) || (param1.altKey))
               {
                  NavigationUtil.nextWord(_loc2_,param1.shiftKey);
               }
               else
               {
                  NavigationUtil.nextCharacter(_loc2_,param1.shiftKey);
               }
            }
         }
         return _loc2_;
      }
      
      private function handleRightArrow(param1:KeyboardEvent) : SelectionState {
         var _loc2_:SelectionState = this.getSelectionState();
         if(this._textFlow.computedFormat.blockProgression != BlockProgression.RL)
         {
            if(this._textFlow.computedFormat.direction == Direction.LTR)
            {
               if((param1.ctrlKey) || (param1.altKey))
               {
                  NavigationUtil.nextWord(_loc2_,param1.shiftKey);
               }
               else
               {
                  NavigationUtil.nextCharacter(_loc2_,param1.shiftKey);
               }
            }
            else
            {
               if((param1.ctrlKey) || (param1.altKey))
               {
                  NavigationUtil.previousWord(_loc2_,param1.shiftKey);
               }
               else
               {
                  NavigationUtil.previousCharacter(_loc2_,param1.shiftKey);
               }
            }
         }
         else
         {
            if(param1.altKey)
            {
               NavigationUtil.startOfParagraph(_loc2_,param1.shiftKey);
            }
            else
            {
               if(param1.ctrlKey)
               {
                  NavigationUtil.startOfDocument(_loc2_,param1.shiftKey);
               }
               else
               {
                  NavigationUtil.previousLine(_loc2_,param1.shiftKey);
               }
            }
         }
         return _loc2_;
      }
      
      private function handleDownArrow(param1:KeyboardEvent) : SelectionState {
         var _loc2_:SelectionState = this.getSelectionState();
         if(this._textFlow.computedFormat.blockProgression != BlockProgression.RL)
         {
            if(param1.altKey)
            {
               NavigationUtil.endOfParagraph(_loc2_,param1.shiftKey);
            }
            else
            {
               if(param1.ctrlKey)
               {
                  NavigationUtil.endOfDocument(_loc2_,param1.shiftKey);
               }
               else
               {
                  NavigationUtil.nextLine(_loc2_,param1.shiftKey);
               }
            }
         }
         else
         {
            if(this._textFlow.computedFormat.direction == Direction.LTR)
            {
               if((param1.ctrlKey) || (param1.altKey))
               {
                  NavigationUtil.nextWord(_loc2_,param1.shiftKey);
               }
               else
               {
                  NavigationUtil.nextCharacter(_loc2_,param1.shiftKey);
               }
            }
            else
            {
               if((param1.ctrlKey) || (param1.altKey))
               {
                  NavigationUtil.previousWord(_loc2_,param1.shiftKey);
               }
               else
               {
                  NavigationUtil.previousCharacter(_loc2_,param1.shiftKey);
               }
            }
         }
         return _loc2_;
      }
      
      private function handleHomeKey(param1:KeyboardEvent) : SelectionState {
         var _loc2_:SelectionState = this.getSelectionState();
         if((param1.ctrlKey) && !param1.altKey)
         {
            NavigationUtil.startOfDocument(_loc2_,param1.shiftKey);
         }
         else
         {
            NavigationUtil.startOfLine(_loc2_,param1.shiftKey);
         }
         return _loc2_;
      }
      
      private function handleEndKey(param1:KeyboardEvent) : SelectionState {
         var _loc2_:SelectionState = this.getSelectionState();
         if((param1.ctrlKey) && !param1.altKey)
         {
            NavigationUtil.endOfDocument(_loc2_,param1.shiftKey);
         }
         else
         {
            NavigationUtil.endOfLine(_loc2_,param1.shiftKey);
         }
         return _loc2_;
      }
      
      private function handlePageUpKey(param1:KeyboardEvent) : SelectionState {
         var _loc2_:SelectionState = this.getSelectionState();
         NavigationUtil.previousPage(_loc2_,param1.shiftKey);
         return _loc2_;
      }
      
      private function handlePageDownKey(param1:KeyboardEvent) : SelectionState {
         var _loc2_:SelectionState = this.getSelectionState();
         NavigationUtil.nextPage(_loc2_,param1.shiftKey);
         return _loc2_;
      }
      
      private function handleKeyEvent(param1:KeyboardEvent) : void {
         var _loc2_:SelectionState = null;
         this.flushPendingOperations();
         switch(param1.keyCode)
         {
            case Keyboard.LEFT:
               _loc2_ = this.handleLeftArrow(param1);
               break;
            case Keyboard.UP:
               _loc2_ = this.handleUpArrow(param1);
               break;
            case Keyboard.RIGHT:
               _loc2_ = this.handleRightArrow(param1);
               break;
            case Keyboard.DOWN:
               _loc2_ = this.handleDownArrow(param1);
               break;
            case Keyboard.HOME:
               _loc2_ = this.handleHomeKey(param1);
               break;
            case Keyboard.END:
               _loc2_ = this.handleEndKey(param1);
               break;
            case Keyboard.PAGE_DOWN:
               _loc2_ = this.handlePageDownKey(param1);
               break;
            case Keyboard.PAGE_UP:
               _loc2_ = this.handlePageUpKey(param1);
               break;
         }
         if(_loc2_ != null)
         {
            param1.preventDefault();
            this.updateSelectionAndShapes(this._textFlow,_loc2_.anchorPosition,_loc2_.activePosition);
            if((this._textFlow.flowComposer) && !(this._textFlow.flowComposer.numControllers == 0))
            {
               this._textFlow.flowComposer.getControllerAt(this._textFlow.flowComposer.numControllers-1).scrollToRange(_loc2_.activePosition,_loc2_.activePosition);
            }
         }
         this.allowOperationMerge = false;
      }
      
      public function keyDownHandler(param1:KeyboardEvent) : void {
         if(!this.hasSelection() || (param1.isDefaultPrevented()))
         {
            return;
         }
         if(param1.charCode == 0)
         {
            switch(param1.keyCode)
            {
               case Keyboard.LEFT:
               case Keyboard.UP:
               case Keyboard.RIGHT:
               case Keyboard.DOWN:
               case Keyboard.HOME:
               case Keyboard.END:
               case Keyboard.PAGE_DOWN:
               case Keyboard.PAGE_UP:
               case Keyboard.ESCAPE:
                  this.handleKeyEvent(param1);
                  break;
            }
         }
         else
         {
            if(param1.keyCode == Keyboard.ESCAPE)
            {
               this.handleKeyEvent(param1);
            }
         }
      }
      
      public function keyUpHandler(param1:KeyboardEvent) : void {
      }
      
      public function keyFocusChangeHandler(param1:FocusEvent) : void {
      }
      
      public function textInputHandler(param1:TextEvent) : void {
         this.ignoreNextTextEvent = false;
      }
      
      public function imeStartCompositionHandler(param1:IMEEvent) : void {
      }
      
      public function softKeyboardActivatingHandler(param1:Event) : void {
      }
      
      protected function enterFrameHandler(param1:Event) : void {
         this.flushPendingOperations();
      }
      
      public function focusChangeHandler(param1:FocusEvent) : void {
      }
      
      public function menuSelectHandler(param1:ContextMenuEvent) : void {
         var _loc2_:ContextMenu = param1.target as ContextMenu;
         if(this.activePosition != this.anchorPosition)
         {
            _loc2_.clipboardItems.copy = true;
            _loc2_.clipboardItems.cut = this.editingMode == EditingMode.READ_WRITE;
            _loc2_.clipboardItems.clear = this.editingMode == EditingMode.READ_WRITE;
         }
         else
         {
            _loc2_.clipboardItems.copy = false;
            _loc2_.clipboardItems.cut = false;
            _loc2_.clipboardItems.clear = false;
         }
         var _loc3_:Clipboard = Clipboard.generalClipboard;
         if(!(this.activePosition == -1) && this.editingMode == EditingMode.READ_WRITE && ((_loc3_.hasFormat(TextClipboard.TEXT_LAYOUT_MARKUP)) || (_loc3_.hasFormat(ClipboardFormats.TEXT_FORMAT))))
         {
            _loc2_.clipboardItems.paste = true;
         }
         else
         {
            _loc2_.clipboardItems.paste = false;
         }
         _loc2_.clipboardItems.selectAll = true;
      }
      
      public function mouseWheelHandler(param1:MouseEvent) : void {
      }
      
      public function flushPendingOperations() : void {
      }
      
      public function getCommonCharacterFormat(param1:TextRange=null) : TextLayoutFormat {
         if(!param1 && !this.hasSelection())
         {
            return null;
         }
         var _loc2_:ElementRange = ElementRange.createElementRange(this._textFlow,param1?param1.absoluteStart:this.absoluteStart,param1?param1.absoluteEnd:this.absoluteEnd);
         var _loc3_:TextLayoutFormat = _loc2_.getCommonCharacterFormat();
         if(_loc2_.absoluteEnd == _loc2_.absoluteStart && (this.pointFormat))
         {
            _loc3_.apply(this.pointFormat);
         }
         return _loc3_;
      }
      
      public function getCommonParagraphFormat(param1:TextRange=null) : TextLayoutFormat {
         if(!param1 && !this.hasSelection())
         {
            return null;
         }
         return ElementRange.createElementRange(this._textFlow,param1?param1.absoluteStart:this.absoluteStart,param1?param1.absoluteEnd:this.absoluteEnd).getCommonParagraphFormat();
      }
      
      public function getCommonContainerFormat(param1:TextRange=null) : TextLayoutFormat {
         if(!param1 && !this.hasSelection())
         {
            return null;
         }
         return ElementRange.createElementRange(this._textFlow,param1?param1.absoluteStart:this.absoluteStart,param1?param1.absoluteEnd:this.absoluteEnd).getCommonContainerFormat();
      }
      
      private function updateSelectionAndShapes(param1:TextFlow, param2:int, param3:int) : void {
         this.internalSetSelection(param1,param2,param3);
         if((this._textFlow.flowComposer) && !(this._textFlow.flowComposer.numControllers == 0))
         {
            this._textFlow.flowComposer.getControllerAt(this._textFlow.flowComposer.numControllers-1).scrollToRange(this.activeMark.position,this.anchorMark.position);
         }
         this.selectionChanged();
         this.clearSelectionShapes();
         this.addSelectionShapes();
      }
      
      private var marks:Array;
      
      tlf_internal function createMark() : Mark {
         var _loc1_:Mark = new Mark(-1);
         this.marks.push(_loc1_);
         return _loc1_;
      }
      
      tlf_internal function removeMark(param1:Mark) : void {
         var _loc2_:int = this.marks.indexOf(param1);
         if(_loc2_ != -1)
         {
            this.marks.splice(_loc2_,_loc2_ + 1);
         }
      }
      
      public function notifyInsertOrDelete(param1:int, param2:int) : void {
         var _loc4_:Mark = null;
         if(param2 == 0)
         {
            return;
         }
         var _loc3_:* = 0;
         while(_loc3_ < this.marks.length)
         {
            _loc4_ = this.marks[_loc3_];
            if(_loc4_.position >= param1)
            {
               if(param2 < 0)
               {
                  _loc4_.position = _loc4_.position + param2 < param1?param1:_loc4_.position + param2;
               }
               else
               {
                  _loc4_.position = _loc4_.position + param2;
               }
            }
            _loc3_++;
         }
      }
   }
}
