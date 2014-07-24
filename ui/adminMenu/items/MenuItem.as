package adminMenu.items
{
   import d2hooks.*;
   
   public class MenuItem extends BasicItem
   {
      
      public function MenuItem() {
         this.children = [];
         super();
      }
      
      public var children:Array;
      
      override public function getContextMenuItem(replaceParam:Object) : Object {
         var child:BasicItem = null;
         var processedChildren:Array = [];
         for each(child in this.children)
         {
            processedChildren.push(child.getContextMenuItem(replaceParam),null,null,false,null,false,true,help);
         }
         return Api.contextMod.createContextMenuItemObject(label,null,null,false,processedChildren,false,true,help);
      }
   }
}
