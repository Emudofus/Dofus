package flashx.textLayout.elements
{
   import flash.utils.Dictionary;
   import flash.text.engine.TextLine;
   import flash.geom.Rectangle;
   import flashx.textLayout.compose.TextFlowLine;
   import flashx.textLayout.tlf_internal;
   import flash.display.Shape;
   import flashx.textLayout.container.ContainerController;
   import flash.display.Sprite;

   use namespace tlf_internal;

   public class BackgroundManager extends Object
   {
         

      public function BackgroundManager() {
         super();
         this._lineDict=new Dictionary(true);
      }



      protected var _lineDict:Dictionary;

      public function addRect(tl:TextLine, fle:FlowLeafElement, r:Rectangle, color:uint, alpha:Number) : void {
         var currRecord:Object = null;
         var entry:Array = this._lineDict[tl];
         if(entry==null)
         {
            entry=this._lineDict[tl]=new Array();
         }
         var record:Object = new Object();
         record.rect=r;
         record.fle=fle;
         record.color=color;
         record.alpha=alpha;
         var fleAbsoluteStart:int = fle.getAbsoluteStart();
         var i:int = 0;
         while(i<entry.length)
         {
            currRecord=entry[i];
            if((currRecord.hasOwnProperty("fle"))&&(currRecord.fle.getAbsoluteStart()==fleAbsoluteStart))
            {
               entry[i]=record;
               return;
            }
            i++;
         }
         entry.push(record);
      }

      public function addNumberLine(tl:TextLine, numberLine:TextLine) : void {
         var entry:Array = this._lineDict[tl];
         if(entry==null)
         {
            entry=this._lineDict[tl]=new Array();
         }
         entry.push({numberLine:numberLine});
      }

      public function finalizeLine(line:TextFlowLine) : void {
         
      }

      tlf_internal function getEntry(line:TextLine) : * {
         return this._lineDict?this._lineDict[line]:undefined;
      }

      public function drawAllRects(textFlow:TextFlow, bgShape:Shape, constrainWidth:Number, constrainHeight:Number) : void {
         var line:Object = null;
         var entry:Array = null;
         var columnRect:Rectangle = null;
         var r:Rectangle = null;
         var record:Object = null;
         var i:* = 0;
         var numberLine:TextLine = null;
         var backgroundManager:BackgroundManager = null;
         var numberEntry:Array = null;
         var ii:* = 0;
         var numberRecord:Object = null;
         for (line in this._lineDict)
         {
            entry=this._lineDict[line];
            if(entry.length)
            {
               columnRect=entry[0].columnRect;
               i=0;
               while(i<entry.length)
               {
                  record=entry[i];
                  if(record.hasOwnProperty("numberLine"))
                  {
                     numberLine=record.numberLine;
                     backgroundManager=TextFlowLine.getNumberLineBackground(numberLine);
                     numberEntry=backgroundManager._lineDict[numberLine];
                     ii=0;
                     while(ii<numberEntry.length)
                     {
                        numberRecord=numberEntry[ii];
                        r=numberRecord.rect;
                        r.x=r.x+(line.x+numberLine.x);
                        r.y=r.y+(line.y+numberLine.y);
                        TextFlowLine.constrainRectToColumn(textFlow,r,columnRect,0,0,constrainWidth,constrainHeight);
                        bgShape.graphics.beginFill(numberRecord.color,numberRecord.alpha);
                        bgShape.graphics.drawRect(r.x,r.y,r.width,r.height);
                        bgShape.graphics.endFill();
                        ii++;
                     }
                  }
                  else
                  {
                     r=record.rect;
                     r.x=r.x+line.x;
                     r.y=r.y+line.y;
                     TextFlowLine.constrainRectToColumn(textFlow,r,columnRect,0,0,constrainWidth,constrainHeight);
                     bgShape.graphics.beginFill(record.color,record.alpha);
                     bgShape.graphics.drawRect(r.x,r.y,r.width,r.height);
                     bgShape.graphics.endFill();
                  }
                  i++;
               }
            }
         }
      }

      public function removeLineFromCache(tl:TextLine) : void {
         delete this._lineDict[[tl]];
      }

      public function onUpdateComplete(controller:ContainerController) : void {
         var bgShape:Shape = null;
         var childIdx:* = 0;
         var tl:TextLine = null;
         var entry:Array = null;
         var r:Rectangle = null;
         var tfl:TextFlowLine = null;
         var i:* = 0;
         var record:Object = null;
         var numberLine:TextLine = null;
         var backgroundManager:BackgroundManager = null;
         var numberEntry:Array = null;
         var ii:* = 0;
         var numberRecord:Object = null;
         var container:Sprite = controller.container;
         if((container)&&(container.numChildren))
         {
            bgShape=controller.getBackgroundShape();
            bgShape.graphics.clear();
            childIdx=0;
            while(childIdx<controller.textLines.length)
            {
               tl=controller.textLines[childIdx];
               entry=this._lineDict[tl];
               if(entry)
               {
                  tfl=tl.userData as TextFlowLine;
                  i=0;
                  while(i<entry.length)
                  {
                     record=entry[i];
                     if(record.hasOwnProperty("numberLine"))
                     {
                        numberLine=record.numberLine;
                        backgroundManager=TextFlowLine.getNumberLineBackground(numberLine);
                        numberEntry=backgroundManager._lineDict[numberLine];
                        ii=0;
                        while(ii<numberEntry.length)
                        {
                           numberRecord=numberEntry[ii];
                           r=numberRecord.rect.clone();
                           r.x=r.x+numberLine.x;
                           r.y=r.y+numberLine.y;
                           tfl.convertLineRectToContainer(r,true);
                           bgShape.graphics.beginFill(numberRecord.color,numberRecord.alpha);
                           bgShape.graphics.drawRect(r.x,r.y,r.width,r.height);
                           bgShape.graphics.endFill();
                           ii++;
                        }
                     }
                     else
                     {
                        r=record.rect.clone();
                        tfl.convertLineRectToContainer(r,true);
                        bgShape.graphics.beginFill(record.color,record.alpha);
                        bgShape.graphics.drawRect(r.x,r.y,r.width,r.height);
                        bgShape.graphics.endFill();
                     }
                     i++;
                  }
               }
               childIdx++;
            }
         }
      }
   }

}