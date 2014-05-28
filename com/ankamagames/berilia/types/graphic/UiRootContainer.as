package com.ankamagames.berilia.types.graphic
{
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.display.Stage;
   import flash.display.Sprite;
   import flash.utils.Timer;
   import com.ankamagames.berilia.types.data.UiData;
   import com.ankamagames.berilia.types.data.UiModule;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.jerakine.types.Callback;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   import com.ankamagames.berilia.types.data.RadioGroup;
   import com.ankamagames.berilia.managers.SecureCenter;
   import flash.errors.IllegalOperationError;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.geom.Point;
   import flash.display.DisplayObject;
   import com.ankamagames.berilia.enums.LocationTypeEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import flash.events.TimerEvent;
   import com.ankamagames.berilia.managers.UiRenderManager;
   
   public class UiRootContainer extends GraphicContainer
   {
      
      public function UiRootContainer(stage:Stage, uiData:UiData, root:Sprite = null) {
         super();
         this._stage = stage;
         this._root = root;
         this._aNamedElements = new Array();
         this._aSizeStack = new Array();
         this._linkedUi = new Array();
         this._uiData = uiData;
         this._aGraphicLocationStack = new Array();
         this._aGraphicElementIndex = new Array();
         this._aPostFinalizeElement = new Array();
         this._aFinalizeElements = new Array();
         this._waitingFctCall = new Array();
         this.radioGroup = new Array();
         super.visible = false;
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary;
      
      protected static const _log:Logger;
      
      private var _aNamedElements:Array;
      
      private var _bUsedCustomSize:Boolean = false;
      
      private var _stage:Stage;
      
      private var _root:Sprite;
      
      private var _aGraphicLocationStack:Array;
      
      private var _aSizeStack:Array;
      
      private var _aGraphicElementIndex:Array;
      
      private var _aPositionnedElement:Array;
      
      private var _linkedUi:Array;
      
      private var _aPostFinalizeElement:Array;
      
      private var _aFinalizeElements:Array;
      
      private var _uiDefinitionUpdateTimer:Timer;
      
      private var _rendering:Boolean = false;
      
      private var _ready:Boolean;
      
      private var _waitingFctCall:Array;
      
      private var _properties;
      
      private var _wasVisible:Boolean;
      
      private var _lock:Boolean = true;
      
      private var _renderAsk:Boolean = false;
      
      private var _isNotFinalized:Boolean = true;
      
      private var _tempVisible:Boolean = true;
      
      private var _uiData:UiData;
      
      public var uiClass;
      
      public var uiModule:UiModule;
      
      public var strata:int;
      
      public var depth:int;
      
      public var scalable:Boolean = true;
      
      public var modal:Boolean = false;
      
      private var _modalContainer:GraphicContainer;
      
      public var giveFocus:Boolean = true;
      
      public var modalIndex:uint = 0;
      
      public var radioGroup:Array;
      
      public var cached:Boolean = false;
      
      public var hideAfterLoading:Boolean = false;
      
      public var transmitFocus:Boolean = true;
      
      public var constants:Array;
      
      public var tempHolder:DisplayObjectContainer;
      
      public function set properties(o:*) : void {
         if(!this._properties)
         {
            this._properties = o;
         }
      }
      
      override public function get customUnicName() : String {
         return name;
      }
      
      override public function set visible(value:Boolean) : void {
         if(this._isNotFinalized)
         {
            this._tempVisible = value;
         }
         else
         {
            super.visible = value;
         }
      }
      
      override public function get width() : Number {
         if(this._bUsedCustomSize)
         {
            return __width;
         }
         return super.width;
      }
      
      override public function set width(nW:Number) : void {
         this._bUsedCustomSize = true;
         __width = nW;
      }
      
      override public function get height() : Number {
         if(this._bUsedCustomSize)
         {
            return __height;
         }
         return super.height;
      }
      
      override public function set height(nH:Number) : void {
         this._bUsedCustomSize = true;
         __height = nH;
      }
      
      public function set useCustomSize(b:Boolean) : void {
         this._bUsedCustomSize = b;
      }
      
      public function get useCustomSize() : Boolean {
         return this._bUsedCustomSize;
      }
      
      public function set disableRender(b:Boolean) : void {
         this._rendering = b;
      }
      
      public function get disableRender() : Boolean {
         return this._rendering;
      }
      
      public function get ready() : Boolean {
         return this._ready;
      }
      
      public function set modalContainer(val:GraphicContainer) : void {
         this._modalContainer = val;
      }
      
      public function set showModalContainer(val:Boolean) : void {
         if((this.modal) && (!(this._modalContainer == null)))
         {
            this._modalContainer.visible = val;
         }
      }
      
      public function get uiData() : UiData {
         return this._uiData;
      }
      
      public function addElement(sName:String, oElement:Object) : void {
         this._aNamedElements[sName] = oElement;
      }
      
      public function removeElement(sName:String) : void {
         delete this._aNamedElements[sName];
      }
      
      public function getElement(sName:String) : GraphicContainer {
         return this._aNamedElements[sName];
      }
      
      public function getElements() : Array {
         return this._aNamedElements;
      }
      
      public function getConstant(name:String) : * {
         return this.constants[name];
      }
      
      public function iAmFinalized(target:FinalizableUIComponent) : void {
         var elem:FinalizableUIComponent = null;
         var t:* = 0;
         var cb:Callback = null;
         if((!this._lock) || (this._rendering))
         {
            return;
         }
         for each(elem in this._aFinalizeElements)
         {
            if(!elem.finalized)
            {
               return;
            }
         }
         this._lock = false;
         this.render();
         this._ready = true;
         if(this.tempHolder)
         {
            if(!this.hideAfterLoading)
            {
               this.tempHolder.parent.addChildAt(this,this.tempHolder.parent.getChildIndex(this.tempHolder));
            }
            this.tempHolder.parent.removeChild(this.tempHolder);
            this.tempHolder = null;
         }
         this._isNotFinalized = false;
         var destroyNow:Boolean = false;
         if((this.uiClass) && (this.uiClass.hasOwnProperty("main")))
         {
            this._rendering = true;
            t = getTimer();
            FpsManager.getInstance().startTracking("hook",7108545);
            ErrorManager.tryFunction(this.uiClass["main"],[this._properties],"Une erreur est survenue lors de l\'exécution de la fonction main de l\'interface " + name + " (" + getQualifiedClassName(this.uiClass) + ")");
            FpsManager.getInstance().stopTracking("hook");
            this._rendering = false;
            if(ErrorManager.lastTryFunctionHasException)
            {
               destroyNow = true;
            }
            else if(this._renderAsk)
            {
               this.render();
            }
            
            this._ready = true;
            for each(cb in this._waitingFctCall)
            {
               cb.exec();
            }
            this._waitingFctCall = null;
         }
         dispatchEvent(new UiRenderEvent(UiRenderEvent.UIRenderComplete,false,false,this));
         this.visible = this._tempVisible;
         if(destroyNow)
         {
            _log.error("UI " + name + " has encountered an exception and must be unloaded.");
            _log.warn("" + ErrorManager.lastExceptionStacktrace);
            Berilia.getInstance().unloadUi(name);
         }
      }
      
      public function render() : void {
         var i:* = 0;
         var ge:GraphicElement = null;
         var pfc:FinalizableUIComponent = null;
         this._renderAsk = true;
         var wasReady:Boolean = this._ready;
         this._ready = false;
         if((this._rendering) || (this._lock))
         {
            return;
         }
         var t1:uint = getTimer();
         this._rendering = true;
         this._aPositionnedElement = new Array();
         this.zSort(this._aSizeStack);
         this.processSize();
         i = 0;
         while(i < this._aGraphicLocationStack.length)
         {
            if(this._aGraphicLocationStack[i] != null)
            {
               this._aGraphicLocationStack[i].render = false;
            }
            i++;
         }
         i = 0;
         while(i < this._aGraphicLocationStack.length)
         {
            if(this._aGraphicLocationStack[i] != null)
            {
               if(!this._aGraphicLocationStack[i].render)
               {
                  ge = this._aGraphicLocationStack[i];
                  if(!ge.sprite.dynamicPosition)
                  {
                     this.processLocation(this._aGraphicLocationStack[i]);
                  }
               }
            }
            i++;
         }
         this.updateLinkedUi();
         for each(pfc in this._aPostFinalizeElement)
         {
            pfc.finalize();
         }
         this._aPositionnedElement = new Array();
         this._rendering = false;
         this._ready = wasReady;
      }
      
      public function registerId(sName:String, geReference:GraphicElement) : void {
         if((!(this._aGraphicElementIndex[sName] == null)) && (!(this._aGraphicElementIndex[sName] == undefined)))
         {
            throw new BeriliaError(sName + " name is already used");
         }
         else
         {
            this._aGraphicElementIndex[sName] = geReference;
            this.addElement(sName,geReference.sprite);
            return;
         }
      }
      
      public function deleteId(sName:String) : void {
         if(this._aGraphicElementIndex[sName] == null)
         {
            return;
         }
         delete this._aGraphicElementIndex[sName];
         this.removeElement(sName);
      }
      
      public function getElementById(sName:String) : GraphicElement {
         return this._aGraphicElementIndex[sName];
      }
      
      public function removeFromRenderList(sName:String) : void {
         var i:uint = 0;
         var ge:GraphicElement = null;
         i = 0;
         while(i < this._aGraphicLocationStack.length)
         {
            ge = this._aGraphicLocationStack[i];
            if((!(ge == null)) && (ge.sprite.name == sName))
            {
               delete this._aGraphicLocationStack[i];
               break;
            }
            i++;
         }
         i = 0;
         while(i < this._aSizeStack.length)
         {
            if((!(this._aSizeStack[i] == null)) && (this._aSizeStack[i].name == sName))
            {
               delete this._aSizeStack[i];
               break;
            }
            i++;
         }
      }
      
      public function addDynamicSizeElement(geReference:GraphicElement) : void {
         var i:uint = 0;
         while(i < this._aSizeStack.length)
         {
            if(this._aSizeStack[i] == geReference)
            {
               return;
            }
            i++;
         }
         this._aSizeStack.push(geReference);
      }
      
      public function addDynamicElement(ge:GraphicElement) : void {
         var i:uint = 0;
         while(i < this._aGraphicLocationStack.length)
         {
            if((!(this._aGraphicLocationStack[i] == null)) && (this._aGraphicLocationStack[i].sprite.name == ge.sprite.name))
            {
               return;
            }
            i++;
         }
         this._aGraphicLocationStack.push(ge);
      }
      
      public function addPostFinalizeComponent(fc:FinalizableUIComponent) : void {
         this._aPostFinalizeElement.push(fc);
      }
      
      public function addFinalizeElement(fc:FinalizableUIComponent) : void {
         this._aFinalizeElements.push(fc);
      }
      
      public function addRadioGroup(groupName:String) : RadioGroup {
         if(!this.radioGroup[groupName])
         {
            this.radioGroup[groupName] = new RadioGroup(groupName);
         }
         return this.radioGroup[groupName];
      }
      
      public function getRadioGroup(name:String) : RadioGroup {
         return this.radioGroup[name];
      }
      
      public function addLinkedUi(uiName:String) : void {
         if(uiName != name)
         {
            this._linkedUi[uiName] = uiName;
         }
         else
         {
            _log.error("Cannot add link to yourself in " + name);
         }
      }
      
      public function removeLinkedUi(uiName:String) : void {
         delete this._linkedUi[uiName];
      }
      
      public function updateLinkedUi() : void {
         var ui:String = null;
         for each(ui in this._linkedUi)
         {
            if(Berilia.getInstance().getUi(this._linkedUi[ui]))
            {
               Berilia.getInstance().getUi(this._linkedUi[ui]).render();
            }
         }
      }
      
      public function call(fct:Function, args:Array, accesKey:Object) : void {
         if(accesKey !== SecureCenter.ACCESS_KEY)
         {
            throw new IllegalOperationError();
         }
         else
         {
            if(this._ready)
            {
               CallWithParameters.call(fct,args);
            }
            else
            {
               this._waitingFctCall.push(CallWithParameters.callConstructor(Callback,[fct].concat(args)));
            }
            return;
         }
      }
      
      public function destroyUi(accesKey:Object) : void {
         var r:RadioGroup = null;
         var num:* = 0;
         var i:* = 0;
         var component:GraphicContainer = null;
         if(accesKey !== SecureCenter.ACCESS_KEY)
         {
            throw new IllegalOperationError();
         }
         else
         {
            for each(r in this.radioGroup)
            {
               RadioGroup(r).destroy();
            }
            this.radioGroup = null;
            this._stage = null;
            this._root = null;
            this._aNamedElements = new Array();
            this._aSizeStack = new Array();
            this._linkedUi = new Array();
            this._aGraphicLocationStack = new Array();
            this._aGraphicElementIndex = new Array();
            this._aPostFinalizeElement = new Array();
            if(this._aFinalizeElements)
            {
               num = this._aFinalizeElements.length;
               i = 0;
               while(i < num)
               {
                  component = this._aFinalizeElements[i];
                  component.remove();
                  i++;
               }
            }
            this._aFinalizeElements = null;
            return;
         }
      }
      
      private function isRegisteredId(sName:String) : Boolean {
         return !(this._aGraphicElementIndex[sName] == null);
      }
      
      private function processSize() : void {
         var ge:GraphicElement = null;
         var i:uint = 0;
         while(i < this._aSizeStack.length)
         {
            ge = this._aSizeStack[i];
            if(ge != null)
            {
               if((!isNaN(ge.size.x)) && (ge.size.xUnit == GraphicSize.SIZE_PRC))
               {
                  if((ge.sprite) && (ge.sprite.parent) && (ge.sprite.parent.parent is UiRootContainer))
                  {
                     ge.sprite.width = int(ge.size.x * StageShareManager.startWidth);
                  }
                  else if(GraphicContainer(ge.sprite).getParent())
                  {
                     ge.sprite.width = int(ge.size.x * GraphicContainer(ge.sprite).getParent().width);
                  }
                  
               }
               if((!isNaN(ge.size.y)) && (ge.size.yUnit == GraphicSize.SIZE_PRC))
               {
                  if((ge.sprite) && (ge.sprite.parent) && (ge.sprite.parent.parent is UiRootContainer))
                  {
                     ge.sprite.height = int(ge.size.y * StageShareManager.startHeight);
                  }
                  else if(GraphicContainer(ge.sprite).getParent())
                  {
                     ge.sprite.height = int(ge.size.y * GraphicContainer(ge.sprite).getParent().height);
                  }
                  
               }
            }
            i++;
         }
      }
      
      public function processLocation(geElem:GraphicElement) : void {
         var ptTopLeftCorner:Point = null;
         var ptBottomRightCorner:Point = null;
         var startValueX:Number = geElem.sprite.x;
         var startValueY:Number = geElem.sprite.y;
         var startOffsetX:Number = geElem.location.getOffsetX();
         var startOffsetY:Number = geElem.location.getOffsetY();
         geElem.sprite.x = 0;
         geElem.sprite.y = 0;
         geElem.location.setOffsetX(startOffsetX);
         geElem.location.setOffsetY(startOffsetY);
         if(geElem.locations.length > 1)
         {
            geElem.sprite.width = 0;
            geElem.sprite.height = 0;
            ptTopLeftCorner = this.getLocation(new Point(geElem.sprite.x,geElem.sprite.y),geElem.locations[0],geElem.sprite);
            ptBottomRightCorner = this.getLocation(new Point(geElem.sprite.x,geElem.sprite.y),geElem.locations[1],geElem.sprite);
            if((ptTopLeftCorner) && (ptBottomRightCorner))
            {
               geElem.sprite.width = Math.floor(Math.abs(ptBottomRightCorner.x - ptTopLeftCorner.x));
               geElem.sprite.height = Math.floor(Math.abs(ptBottomRightCorner.y - ptTopLeftCorner.y));
            }
            else
            {
               _log.error("Erreur de positionement dans " + name + " avec " + geElem.name);
            }
         }
         var ptNewPos:Point = this.getLocation(new Point(geElem.sprite.x,geElem.sprite.y),geElem.location,geElem.sprite);
         if((geElem.sprite) && (ptNewPos))
         {
            geElem.sprite.x = ptNewPos.x;
            geElem.sprite.y = ptNewPos.y;
         }
         else
         {
            geElem.sprite.x = startValueX;
            geElem.sprite.y = startValueY;
            _log.error("Erreur dans " + name + " avec " + geElem.name);
         }
      }
      
      private function getLocation(ptStart:Point, glLocation:GraphicLocation, doTarget:DisplayObject) : Point {
         var doRelative:DisplayObject = null;
         var ref:DisplayObject = null;
         var uiTarget:Array = null;
         var ui:UiRootContainer = null;
         var pModificator:Point = new Point();
         var pRef:Point = new Point();
         var pTarget:Point = new Point();
         if((glLocation.offsetXType == LocationTypeEnum.LOCATION_TYPE_RELATIVE) || (glLocation.offsetYType == LocationTypeEnum.LOCATION_TYPE_RELATIVE))
         {
            pRef = doTarget.localToGlobal(new Point(doTarget.x,doTarget.y));
            switch(glLocation.getRelativeTo())
            {
               case GraphicLocation.REF_PARENT:
                  pModificator.x = Math.floor(GraphicContainer(doTarget).getParent().width * glLocation.getOffsetX());
                  pModificator.y = Math.floor(GraphicContainer(doTarget).getParent().height * glLocation.getOffsetY());
                  break;
            }
            if(glLocation.offsetXType == LocationTypeEnum.LOCATION_TYPE_RELATIVE)
            {
               ptStart.x = ptStart.x + pModificator.x;
            }
            if(glLocation.offsetYType == LocationTypeEnum.LOCATION_TYPE_RELATIVE)
            {
               ptStart.y = ptStart.y + pModificator.y;
            }
         }
         if((glLocation.offsetXType == LocationTypeEnum.LOCATION_TYPE_ABSOLUTE) || (glLocation.offsetYType == LocationTypeEnum.LOCATION_TYPE_ABSOLUTE))
         {
            pModificator.x = 0;
            pModificator.y = 0;
            pRef = doTarget.localToGlobal(new Point(doTarget.x,doTarget.y));
            switch(glLocation.getRelativeTo())
            {
               case GraphicLocation.REF_PARENT:
                  pModificator.x = glLocation.getOffsetX();
                  pModificator.y = glLocation.getOffsetY();
                  break;
               case GraphicLocation.REF_SCREEN:
                  pTarget = doTarget.localToGlobal(new Point(doTarget.x,doTarget.y));
                  pModificator.x = glLocation.getOffsetX() - pTarget.x;
                  pModificator.y = glLocation.getOffsetY() - pTarget.y;
                  break;
               case GraphicLocation.REF_TOP:
                  pTarget = new Point(x,y);
                  pModificator.x = glLocation.getOffsetX() + (pTarget.x - pRef.x);
                  pModificator.y = glLocation.getOffsetY() + (pTarget.y - pRef.y);
                  break;
               default:
                  if(this.isRegisteredId(glLocation.getRelativeTo()))
                  {
                     ref = this._aGraphicElementIndex[glLocation.getRelativeTo()].sprite;
                  }
                  else if(Berilia.getInstance().getUi(glLocation.getRelativeTo()))
                  {
                     ref = Berilia.getInstance().getUi(glLocation.getRelativeTo());
                     UiRootContainer(ref).addLinkedUi(name);
                     doTarget = ref;
                  }
                  else if(glLocation.getRelativeTo().indexOf(".") != -1)
                  {
                     uiTarget = glLocation.getRelativeTo().split(".");
                     ui = Berilia.getInstance().getUi(uiTarget[0]);
                     if(!ui)
                     {
                        _log.warn("[Warning] UI " + uiTarget[0] + " does not exist (found " + glLocation.getRelativeTo() + " in " + name + ")");
                        return null;
                     }
                     if(!ui.getElementById(uiTarget[1]))
                     {
                        _log.warn("[Warning] UI " + uiTarget[0] + " does not contain element [" + uiTarget[1] + "] (found " + glLocation.getRelativeTo() + " in " + name + ")");
                        return null;
                     }
                     ref = ui.getElementById(uiTarget[1]).sprite;
                     pRef = doTarget.localToGlobal(new Point(doTarget.x,doTarget.y));
                     GraphicContainer(ref).getUi().addLinkedUi(name);
                  }
                  else
                  {
                     _log.warn("[Warning] " + glLocation.getRelativeTo() + " is unknow graphic element reference");
                     return null;
                  }
                  
                  
                  pTarget = doTarget.localToGlobal(new Point(ref.x,ref.y));
                  pModificator.x = glLocation.getOffsetX() + (pTarget.x - pRef.x);
                  pModificator.y = glLocation.getOffsetY() + (pTarget.y - pRef.y);
            }
            if(glLocation.offsetXType == LocationTypeEnum.LOCATION_TYPE_ABSOLUTE)
            {
               ptStart.x = ptStart.x + pModificator.x;
            }
            if(glLocation.offsetYType == LocationTypeEnum.LOCATION_TYPE_ABSOLUTE)
            {
               ptStart.y = ptStart.y + pModificator.y;
            }
         }
         pModificator = this.getOffsetModificator(glLocation.getPoint(),doTarget);
         ptStart.x = ptStart.x - pModificator.x;
         ptStart.y = ptStart.y - pModificator.y;
         switch(glLocation.getRelativeTo())
         {
            case GraphicLocation.REF_PARENT:
               if((doTarget.parent) && (doTarget.parent.parent))
               {
                  doRelative = doTarget.parent.parent;
               }
               break;
            case GraphicLocation.REF_SCREEN:
               doRelative = this._root;
               break;
            case GraphicLocation.REF_TOP:
               doRelative = this;
               break;
            default:
               doRelative = ref;
               if(doRelative == doTarget)
               {
                  _log.warn("[Warning] Wrong relative position : " + doRelative.name + " refer to himself");
               }
         }
         pModificator = this.getOffsetModificator(glLocation.getRelativePoint(),doRelative);
         ptStart.x = ptStart.x + pModificator.x;
         ptStart.y = ptStart.y + pModificator.y;
         return ptStart;
      }
      
      private function getOffsetModificator(nPoint:uint, doTarget:DisplayObject) : Point {
         var nWidth:uint = (doTarget == null) || (doTarget is UiRootContainer)?StageShareManager.startWidth:doTarget.width;
         var nHeight:uint = (doTarget == null) || (doTarget is UiRootContainer)?StageShareManager.startHeight:doTarget.height;
         var pModificator:Point = new Point(0,0);
         switch(nPoint)
         {
            case LocationEnum.POINT_TOPLEFT:
               break;
            case LocationEnum.POINT_TOP:
               pModificator.x = nWidth / 2;
               break;
            case LocationEnum.POINT_TOPRIGHT:
               pModificator.x = nWidth;
               break;
            case LocationEnum.POINT_LEFT:
               pModificator.y = nWidth / 2;
               break;
            case LocationEnum.POINT_CENTER:
               pModificator.x = nWidth / 2;
               pModificator.y = nHeight / 2;
               break;
            case LocationEnum.POINT_RIGHT:
               pModificator.x = nWidth;
               pModificator.y = nHeight / 2;
               break;
            case LocationEnum.POINT_BOTTOMLEFT:
               pModificator.y = nHeight;
               break;
            case LocationEnum.POINT_BOTTOM:
               pModificator.x = nWidth / 2;
               pModificator.y = nHeight;
               break;
            case LocationEnum.POINT_BOTTOMRIGHT:
               pModificator.x = nWidth;
               pModificator.y = nHeight;
               break;
         }
         return pModificator;
      }
      
      private function zSort(aSort:Array) : Boolean {
         var ge:GraphicElement = null;
         var gl:GraphicLocation = null;
         var i:uint = 0;
         var j:uint = 0;
         var k:uint = 0;
         var bChange:Boolean = true;
         var bSwap:Boolean = false;
         while(bChange)
         {
            bChange = false;
            i = 0;
            while(i < aSort.length)
            {
               ge = aSort[i];
               if(ge != null)
               {
                  j = 0;
                  while(j < ge.locations.length)
                  {
                     k = i + 1;
                     while(k < aSort.length)
                     {
                        gl = ge.locations[j];
                        if(aSort[k] != null)
                        {
                           if((!(gl.getRelativeTo().charAt(0) == "$")) && (gl.getRelativeTo() == aSort[k].sprite.name) || (gl.getRelativeTo() == GraphicLocation.REF_PARENT) && (aSort[k].sprite == ge.sprite.getParent()))
                           {
                              bSwap = true;
                              bChange = true;
                              aSort[i] = aSort[k];
                              aSort[k] = ge;
                              break;
                           }
                        }
                        k++;
                     }
                     j++;
                  }
               }
               i++;
            }
         }
         return bSwap;
      }
      
      private function onDefinitionUpdateTimer(e:TimerEvent) : void {
         UiRenderManager.getInstance().updateCachedUiDefinition();
         this._uiDefinitionUpdateTimer.removeEventListener(TimerEvent.TIMER,this.onDefinitionUpdateTimer);
         this._uiDefinitionUpdateTimer = null;
      }
   }
}
