package com.ankamagames.dofus.misc.utils
{
   import flash.display.Shape;
   import flash.geom.ColorTransform;
   import flash.text.TextField;
   import flash.display.Sprite;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.MouseEvent;
   import flash.events.KeyboardEvent;
   import flash.display.DisplayObject;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import flash.geom.Rectangle;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.ComboBox;
   import flash.display.Stage;
   import com.ankamagames.berilia.types.data.BeriliaUiElementSound;
   import avmplus.getQualifiedClassName;
   import com.ankamagames.berilia.managers.UiSoundManager;
   import __AS3__.vec.Vector;
   import flash.ui.Keyboard;
   import flash.desktop.Clipboard;
   import flash.desktop.ClipboardFormats;
   import flash.text.TextFormat;
   import flash.text.TextFieldAutoSize;


   public class UiInspector extends Object
   {
         

      public function UiInspector() {
         this._highlightEffect=new ColorTransform(1.2,1.2,1.2);
         this._normalEffect=new ColorTransform(1,1,1);
         this._tooltipTf=new TextField();
         this._tooltip=new Sprite();
         super();
         this._highlightShape=new Shape();
         this._highlightShape2=new Shape();
         this._tooltip.mouseEnabled=false;
         this._tooltipTf.mouseEnabled=false;
         var tf:TextFormat = new TextFormat("Verdana");
         this._tooltipTf.defaultTextFormat=tf;
         this._tooltipTf.setTextFormat(tf);
         this._tooltipTf.multiline=true;
         this._tooltip.addChild(this._tooltipTf);
         this._tooltipTf.autoSize=TextFieldAutoSize.LEFT;
      }



      private var _highlightShape:Shape;

      private var _highlightShape2:Shape;

      private var _highlightEffect:ColorTransform;

      private var _normalEffect:ColorTransform;

      private var _tooltipTf:TextField;

      private var _tooltip:Sprite;

      private var _enable:Boolean;

      private var _lastTarget:GraphicContainer;

      public function set enable(b:Boolean) : void {
         if(b)
         {
            StageShareManager.stage.addEventListener(MouseEvent.MOUSE_OVER,this.onRollover);
            StageShareManager.stage.addEventListener(MouseEvent.MOUSE_OUT,this.onRollout);
            StageShareManager.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         }
         else
         {
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_OVER,this.onRollover);
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_OUT,this.onRollout);
            StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
            this.onRollout(this._lastTarget);
         }
         this._enable=b;
      }

      public function get enable() : Boolean {
         return this._enable;
      }

      private function onRollout(arg:*) : void {
         var gc:GraphicContainer = null;
         if(this._highlightShape2.parent)
         {
            StageShareManager.stage.removeChild(this._highlightShape2);
         }
         if(this._highlightShape.parent)
         {
            StageShareManager.stage.removeChild(this._highlightShape);
         }
         if(this._tooltip.parent)
         {
            StageShareManager.stage.removeChild(this._tooltip);
         }
         var elems:Array = this.getBeriliaElement(arg is DisplayObject?arg:arg.target);
         for each (gc in elems)
         {
            if(gc is UiRootContainer)
            {
               gc.transform.colorTransform=this._normalEffect;
            }
         }
      }

      private function onRollover(e:MouseEvent) : void {
         var firstElem:* = false;
         var firstUi:* = false;
         var pos:Rectangle = null;
         var target:GraphicContainer = null;
         var parentElement:GraphicContainer = null;
         var gc:GraphicContainer = null;
         var elems:Array = this.getBeriliaElement(e.target as DisplayObject);
         for each (gc in elems)
         {
            if(gc is UiRootContainer)
            {
               firstUi=true;
               StageShareManager.stage.addChild(this._highlightShape2);
               pos=gc.getBounds(StageShareManager.stage);
               this._highlightShape2.graphics.clear();
               this._highlightShape2.graphics.lineStyle(2,255,0.7);
               this._highlightShape2.graphics.beginFill(255,0);
               this._highlightShape2.graphics.drawRect(pos.left,pos.top,pos.width,pos.height);
               this._highlightShape2.graphics.endFill();
               this._uiRoot=gc as UiRootContainer;
            }
            else
            {
               this._lastTarget=target=gc;
               firstElem=true;
               StageShareManager.stage.addChild(this._highlightShape);
               pos=gc.getBounds(StageShareManager.stage);
               this._highlightShape.graphics.clear();
               this._highlightShape.graphics.lineStyle(3,0,0.7);
               this._highlightShape.graphics.beginFill(16711680,0.0);
               this._highlightShape.graphics.drawRect(pos.left,pos.top,pos.width,pos.height);
               this._highlightShape.graphics.endFill();
            }
         }
         this.buildTooltip(target,parentElement);
      }

      private function getBeriliaElement(target:DisplayObject) : Array {
         var result:Array = [];
         for(;(target)&&(!(target is Stage))&&(target.parent);continue loop0)
         {
            if((target is UiRootContainer)||(target is GraphicContainer))
            {
               result.push(target);
            }
            target=target.parent;
         }
         return result;
      }

      private var _uiRoot:UiRootContainer;

      private function getGraphicContainerInfo(target:GraphicContainer, title:String, ind:String="") : String {
         var soundParam:BeriliaUiElementSound = null;
         var str:String = "";
         var color:String = "#0";
         if(target.name.indexOf("instance")==0)
         {
            color="#FF0000";
         }
         str=ind+"<font size=\'16\'><b>"+title+"</b></font><br/>";
         str=str+(ind+"<b>Nom : </b><font color=\'"+color+"\'>"+target.name+"</font><br/>");
         str=str+(ind+"<b>Type : </b>"+getQualifiedClassName(target).split("::").pop()+"<br/>");
         var soundParams:Vector.<BeriliaUiElementSound> = UiSoundManager.getInstance().getAllSoundUiElement(target);
         str=str+(ind+"<b>Sons : </b>"+(soundParams.length?"":"Aucun")+"<br/>");
         if(soundParams.length)
         {
            for each (soundParam in soundParams)
            {
               str=str+(ind+"&nbsp;&nbsp;&nbsp; - "+soundParam.hook+" : "+soundParam.file+"<br/>");
            }
         }
         return str;
      }

      private function buildTooltip(target:GraphicContainer, parentTarget:GraphicContainer) : void {
         var str:String = "";
         var help:String = "";
         var ind:String = "";
         if(parentTarget)
         {
            str=str+this.getGraphicContainerInfo(parentTarget,"Elément parent",ind);
            ind="&nbsp;&nbsp;&nbsp;";
         }
         if(target)
         {
            str=str+this.getGraphicContainerInfo(target,"Elément",ind);
            help="<br/>---------- AIDE ---------<br/>";
            help=help+"[Ctrl + c] : Copier ces informations<br/>";
            help=help+"[Ctrl + Shift + s] : Cmd son survol<br/>";
            help=help+"[Ctrl + Shift + c] : Cmd son clique<br/>";
            help=help+"[Ctrl + Shift + i] : Cmd inspecter element";
         }
         if((this._uiRoot)&&(this._uiRoot.uiData))
         {
            if(target)
            {
               str=str+"<br/>";
            }
            str=str+"<font size=\'16\'><b>Interface</b></font><br/>";
            str=str+("<b>Nom : </b>"+this._uiRoot.uiData.name+"<br/>");
            str=str+("<b>Module : </b>"+this._uiRoot.uiData.module.id+"<br/>");
            str=str+("<b>Script : </b>"+this._uiRoot.uiData.uiClassName+"<br/>");
         }
         str=str+help;
         if(str.length)
         {
            this._tooltipTf.htmlText=str;
            this._tooltip.graphics.clear();
            this._tooltip.graphics.beginFill(16777215,0.9);
            this._tooltip.graphics.lineStyle(1,0,0.7);
            this._tooltip.graphics.drawRect(-5,-5,this._tooltipTf.width*1.1+10,this._tooltipTf.textHeight*1.1+10);
            this._tooltip.graphics.endFill();
            if(target)
            {
               this._tooltip.x=StageShareManager.mouseX;
               this._tooltip.y=StageShareManager.mouseY-this._tooltip.height-5;
               if(this._tooltip.y<0)
               {
                  this._tooltip.y=5;
               }
               if(this._tooltip.x+this._tooltip.width>StageShareManager.startWidth)
               {
                  this._tooltip.x=this._tooltip.x+(StageShareManager.startWidth-this._tooltip.x+this._tooltip.width);
               }
            }
            else
            {
               this._tooltip.x=this._tooltip.y=0;
            }
            StageShareManager.stage.addChild(this._tooltip);
         }
      }

      private function onKeyUp(e:KeyboardEvent) : void {
         if((e.ctrlKey)&&(e.keyCode==Keyboard.C))
         {
            if(this._lastTarget)
            {
               if(!e.shiftKey)
               {
                  Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,this._tooltipTf.text);
               }
               else
               {
                  Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,"/adduisoundelement "+this._lastTarget.getUi().uiData.name+" "+this._lastTarget.name+" onRelease [ID_SON]");
               }
            }
         }
         if((e.ctrlKey)&&(e.keyCode==Keyboard.S))
         {
            if((this._lastTarget is Grid)||(this._lastTarget is ComboBox))
            {
               Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,"/adduisoundelement "+this._lastTarget.getUi().uiData.name+" "+this._lastTarget.name+" onItemRollOver [ID_SON]");
            }
            else
            {
               Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,"/adduisoundelement "+this._lastTarget.getUi().uiData.name+" "+this._lastTarget.name+" onRollOver [ID_SON]");
            }
         }
         if((e.ctrlKey)&&(e.keyCode==Keyboard.I))
         {
            Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,"/inspectuielement "+this._lastTarget.getUi().uiData.name+" "+this._lastTarget.name);
            this.enable=false;
         }
      }
   }

}