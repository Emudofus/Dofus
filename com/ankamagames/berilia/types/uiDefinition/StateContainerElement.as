package com.ankamagames.berilia.types.uiDefinition
{
   public class StateContainerElement extends ContainerElement
   {
      
      public function StateContainerElement() {
         this.stateChangingProperties = new Array();
         super();
      }
      
      public var stateChangingProperties:Array;
   }
}
