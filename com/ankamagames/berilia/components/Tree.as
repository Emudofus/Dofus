package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.UIComponent;
   import __AS3__.vec.Vector;
   import com.ankamagames.berilia.types.data.TreeData;
   import flash.errors.IllegalOperationError;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.components.gridRenderer.TreeGridRenderer;


   public class Tree extends Grid implements UIComponent
   {
         

      public function Tree() {
         super();
         _sRendererName=getQualifiedClassName(TreeGridRenderer);
      }



      protected var _realDataProvider;

      protected var _treeDataProvider:Vector.<TreeData>;

      override public function set rendererName(value:String) : void {
         throw new IllegalOperationError("rendererName cannot be set");
      }

      override public function set dataProvider(data:*) : void {
         this._realDataProvider=data;
         this._treeDataProvider=TreeData.fromArray(data);
         super.dataProvider=this.makeDataProvider(this._treeDataProvider);
      }

      override public function get dataProvider() : * {
         return this._realDataProvider;
      }

      public function rerender() : void {
         super.dataProvider=this.makeDataProvider(this._treeDataProvider);
      }

      private function makeDataProvider(v:Vector.<TreeData>, result:Vector.<TreeData>=null) : Vector.<TreeData> {
         var node:TreeData = null;
         if(!result)
         {
            result=new Vector.<TreeData>();
         }
         for each (node in v)
         {
            result.push(node);
            if(node.expend)
            {
               this.makeDataProvider(node.children,result);
            }
         }
         return result;
      }
   }

}