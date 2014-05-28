package com.ankamagames.berilia.components.params
{
   import com.ankamagames.berilia.utils.UiProperties;
   import com.ankamagames.jerakine.utils.memory.WeakProxyReference;
   import com.ankamagames.berilia.components.Grid;
   
   public class GridScriptProperties extends UiProperties
   {
      
      public function GridScriptProperties(d:*, b:Boolean = false, grid:Grid = null) {
         super();
         this.data = d;
         this.selected = b;
         this.grid = new WeakProxyReference(grid);
      }
      
      public var data;
      
      public var selected:Boolean;
      
      public var grid:WeakProxyReference;
   }
}
