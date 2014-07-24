package contextMenu
{
   import flash.utils.setTimeout;
   import d2hooks.*;
   import d2actions.*;
   import flash.utils.getTimer;
   import flash.geom.Point;
   import d2components.GraphicContainer;
   
   public class ContextMenuManager extends Object
   {
      
      public function ContextMenuManager() {
         this._contextMenuTree = new Array();
         super();
         if(_self)
         {
         }
         Api.system.addHook(MouseClick,this.onGenericMouseClick);
      }
      
      private static var _self:ContextMenuManager;
      
      public static function getInstance() : ContextMenuManager {
         if(!_self)
         {
            _self = new ContextMenuManager();
         }
         return _self;
      }
      
      private var _contextMenuTree:Array;
      
      private var _currentFocus:Object;
      
      private var _cancelNextClick:Boolean = false;
      
      private var _openDate:uint;
      
      private var _closeCallback:Function;
      
      public var mainUiLoaded:Boolean;
      
      public function openNew(menu:Array, positionReference:Object = null, closeCallback:Function = null, directOpen:Boolean = false) : void {
         var ui:Object = null;
         if(menu == null)
         {
            return;
         }
         if(!directOpen)
         {
            setTimeout(this.openNew,1,menu,positionReference,closeCallback,true);
            return;
         }
         if(menu.length > 0)
         {
            if(this._contextMenuTree.length)
            {
               for each(ui in this._contextMenuTree)
               {
                  Api.ui.unloadUi(ui.name);
               }
               if(this._closeCallback != null)
               {
                  this._closeCallback();
               }
            }
            this._openDate = getTimer();
            this._closeCallback = closeCallback;
            this._contextMenuTree = new Array();
            this.mainUiLoaded = false;
            this._contextMenuTree.push(Api.ui.loadUi("contextMenu","Ankama_ContextMenu",[menu,positionReference],3));
         }
      }
      
      public function openChild(args:Object) : void {
         this._contextMenuTree.push(Api.ui.loadUi("contextMenu","Ankama_SubContextMenu" + this._contextMenuTree.length,args,3));
      }
      
      public function closeChild(contextMenuChild:Object) : void {
         if(this._contextMenuTree.indexOf(contextMenuChild) == -1)
         {
            return;
         }
         while((this._contextMenuTree.length) && (!(this._contextMenuTree[this._contextMenuTree.length - 1] == contextMenuChild)))
         {
            Api.ui.unloadUi(this._contextMenuTree.pop().name);
         }
      }
      
      public function closeAll() : void {
         if(!this._contextMenuTree.length)
         {
            return;
         }
         while(this._contextMenuTree.length)
         {
            Api.ui.unloadUi(this._contextMenuTree.pop().name);
         }
         if(this._closeCallback != null)
         {
            this._closeCallback();
         }
      }
      
      public function childHasFocus(contextMenu:Object) : Boolean {
         var i:uint = this._contextMenuTree.length - 1;
         while(i >= 0)
         {
            if(this._contextMenuTree[i] == contextMenu)
            {
               return false;
            }
            if(this._contextMenuTree[i] == this._currentFocus)
            {
               return true;
            }
            i--;
         }
         return false;
      }
      
      public function setCurrentFocus(contextMenu:Object) : void {
         this._currentFocus = contextMenu;
      }
      
      public function placeMe(contextMenu:Object, mainCtr:Object, startPoint:Point) : void {
         var p:Object = null;
         var p2:Object = null;
         var newX:int = startPoint.x;
         var newY:int = startPoint.y;
         if(newX + mainCtr.width > Api.ui.getStageWidth())
         {
            p = this.getParent(contextMenu);
            if(p)
            {
               newX = p.getElement("mainCtr").x - mainCtr.width;
            }
            else
            {
               newX = newX - mainCtr.width;
            }
         }
         if(newY + mainCtr.height > Api.ui.getStageHeight())
         {
            p2 = this.getParent(contextMenu);
            if(p2)
            {
               newY = newY - mainCtr.height;
            }
            else
            {
               newY = newY - mainCtr.height;
            }
         }
         if(newX < 0)
         {
            newX = 0;
         }
         if(newY < 0)
         {
            newY = 0;
         }
         mainCtr.x = newX;
         mainCtr.y = newY;
      }
      
      public function getTopParent() : Object {
         return this._contextMenuTree[0];
      }
      
      public function getParent(contextMenu:Object) : Object {
         var i:uint = 0;
         while(i < this._contextMenuTree.length)
         {
            if(this._contextMenuTree[i] == contextMenu)
            {
               return this._contextMenuTree[i - 1];
            }
            i++;
         }
         return this._contextMenuTree[this._contextMenuTree.length - 1];
      }
      
      private function onGenericMouseClick(target:Object) : void {
         var ui:Object = null;
         try
         {
            ui = target is GraphicContainer?target.getUi():null;
         }
         catch(e:Error)
         {
         }
         if((!ui) || (this._contextMenuTree.indexOf(ui) == -1))
         {
            this.closeAll();
         }
      }
   }
}
