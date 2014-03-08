package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.UIComponent;
   import __AS3__.vec.Vector;
   import com.ankamagames.berilia.types.data.TreeData;
   import flash.errors.IllegalOperationError;
   import com.ankamagames.berilia.managers.SecureCenter;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.components.gridRenderer.TreeGridRenderer;
   
   public class Tree extends Grid implements UIComponent
   {
      
      public function Tree() {
         super();
         _sRendererName = getQualifiedClassName(TreeGridRenderer);
      }
      
      protected var _realDataProvider;
      
      protected var _treeDataProvider:Vector.<TreeData>;
      
      override public function set rendererName(param1:String) : void {
         throw new IllegalOperationError("rendererName cannot be set");
      }
      
      override public function set dataProvider(param1:*) : void {
         this._realDataProvider = param1;
         this._treeDataProvider = TreeData.fromArray(param1);
         super.dataProvider = this.makeDataProvider(this._treeDataProvider);
      }
      
      override public function get dataProvider() : * {
         return this._realDataProvider;
      }
      
      public function get treeRoot() : TreeData {
         var _loc1_:TreeData = null;
         if(_dataProvider.length > 0)
         {
            _loc1_ = _dataProvider[0].parent;
         }
         return _loc1_;
      }
      
      public function rerender() : void {
         super.dataProvider = this.makeDataProvider(this._treeDataProvider);
      }
      
      public function expandItems(param1:Array) : void {
         var _loc2_:Object = null;
         var _loc3_:TreeData = null;
         if(!param1)
         {
            return;
         }
         for each (_loc2_ in param1)
         {
            _loc3_ = SecureCenter.unsecure(_loc2_) as TreeData;
            if(_loc3_.children.length > 0)
            {
               _loc3_.expend = true;
            }
         }
         this.rerender();
      }
      
      private function makeDataProvider(param1:Vector.<TreeData>, param2:Vector.<TreeData>=null) : Vector.<TreeData> {
         var _loc3_:TreeData = null;
         if(!param2)
         {
            param2 = new Vector.<TreeData>();
         }
         for each (_loc3_ in param1)
         {
            param2.push(_loc3_);
            if(_loc3_.expend)
            {
               this.makeDataProvider(_loc3_.children,param2);
            }
         }
         return param2;
      }
   }
}
