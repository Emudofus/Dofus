package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   
   public class StateContainer extends GraphicContainer implements UIComponent
   {
      
      public function StateContainer() {
         this._describeType = DescribeTypeCache.typeDescription;
         super();
         this._state = StatesEnum.STATE_NORMAL;
         this._snapshot = new Array();
         this._lockedProperties = new Array();
         this._lockedPropertiesStr = "";
         this.lockedProperties = "x,y,width,height,selected,greyedOut";
      }
      
      protected static const _log:Logger;
      
      protected var _state;
      
      protected var _snapshot:Array;
      
      protected var _describeType:Function;
      
      protected var _lockedProperties:Array;
      
      protected var _lockedPropertiesStr:String;
      
      private var _changingStateData:Array;
      
      public function get changingStateData() : Array {
         return this._changingStateData;
      }
      
      public function set changingStateData(value:Array) : void {
         this._changingStateData = value;
      }
      
      public function set state(newState:*) : void {
         if(this._state == newState)
         {
            return;
         }
         if(newState == null)
         {
            newState = StatesEnum.STATE_NORMAL;
         }
         this.changeState(newState);
         this._state = newState;
      }
      
      public function get state() : * {
         return this._state;
      }
      
      override public function free() : void {
         super.free();
         this._state = null;
         this._snapshot = null;
      }
      
      override public function remove() : void {
         super.remove();
         this._snapshot = null;
         this._state = null;
      }
      
      public function get lockedProperties() : String {
         return this._lockedPropertiesStr;
      }
      
      public function set lockedProperties(s:String) : void {
         var tmp:Array = null;
         var propName:String = null;
         this._lockedPropertiesStr = s;
         this._lockedProperties = [];
         if(this._lockedPropertiesStr)
         {
            tmp = s.split(",");
            for each(propName in tmp)
            {
               this._lockedProperties[propName] = true;
            }
         }
      }
      
      protected function changeState(newState:*) : void {
         var target:GraphicContainer = null;
         var properties:Array = null;
         var ui:UiRootContainer = null;
         var key:String = null;
         var property:String = null;
         if(!this._snapshot)
         {
            return;
         }
         if(newState == StatesEnum.STATE_NORMAL)
         {
            this._state = newState;
            this.restoreSnapshot(StatesEnum.STATE_NORMAL);
         }
         else if((!(this.changingStateData == null)) && (this.changingStateData[newState]))
         {
            this._snapshot[this._state] = new Array();
            if(this._state != StatesEnum.STATE_NORMAL)
            {
               this.restoreSnapshot(StatesEnum.STATE_NORMAL);
            }
            for(key in this.changingStateData[newState])
            {
               ui = getUi();
               if(!ui)
               {
                  break;
               }
               target = ui.getElement(key);
               if(target)
               {
                  if(this._state == StatesEnum.STATE_NORMAL)
                  {
                     this.makeSnapshot(StatesEnum.STATE_NORMAL,target);
                  }
                  properties = this.changingStateData[newState][key];
                  for(property in properties)
                  {
                     target[property] = properties[property];
                  }
                  this.makeSnapshot(this._state,target);
               }
            }
         }
         else
         {
            _log.warn(name + " : No data for state \'" + newState + "\' (" + this.changingStateData.length + " states)");
         }
         
      }
      
      protected function makeSnapshot(currentState:*, target:GraphicContainer) : void {
         var property:String = null;
         var propertyXml:XML = null;
         if(!this._snapshot[currentState])
         {
            this._snapshot[currentState] = new Object();
         }
         if(!this._snapshot[currentState][target.name])
         {
            this._snapshot[currentState][target.name] = new Object();
            def = this._describeType(target);
            for each (propertyXml in def..accessor)
            {
               if(propertyXml.@access == "readwrite")
               {
                  property = propertyXml.@name;
                  if(!(this._lockedProperties[property]))
                  {
                     switch(true)
                     {
                        case target[property] is Boolean:
                        case target[property] is uint:
                        case target[property] is int:
                        case target[property] is Number:
                        case target[property] is String:
                        case target[property] == null:
                           this._snapshot[currentState][target.name][property] = target[property];
                           break;
                     }
                  }
               }
            }
            return;
         }
      }
      
      protected function restoreSnapshot(currentState:*) : void {
         var component:GraphicContainer = null;
         var ui:UiRootContainer = null;
         var target:String = null;
         var property:String = null;
         if(!this._snapshot)
         {
            return;
         }
         for (target in this._snapshot[currentState])
         {
            ui = getUi();
            if(!ui)
            {
               break;
            }
            component = ui.getElement(target);
            if(component)
            {
               for (property in this._snapshot[currentState][target])
               {
                  if(component[property] !== this._snapshot[currentState][target][property])
                  {
                     if((!(component is ButtonContainer)) || (!(property == "selected")))
                     {
                        if(!(this._lockedProperties[property]))
                        {
                           component[property] = this._snapshot[currentState][target][property];
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
