package ui
{
   import d2components.GraphicContainer;
   import d2components.Texture;
   import flash.geom.ColorTransform;
   import flash.filters.GlowFilter;
   
   public class AbstractWorldCharacterTooltipUi extends Object
   {
      
      public function AbstractWorldCharacterTooltipUi() {
         super();
      }
      
      protected function showAlignmentWings(oParam:Object) : void {
         var alignmentInfos:Object = null;
         var w:* = 0;
         var data:Object = oParam.data;
         var uiInstance:Object = this["uiApi"].me();
         var alignmentUri:String = uiInstance.getConstant("alignment");
         var tx_back:GraphicContainer = uiInstance.getElement("tx_back") as GraphicContainer;
         var ctr_alignment_bottom:GraphicContainer = uiInstance.getElement("ctr_alignment_bottom") as GraphicContainer;
         var ctr_alignment_top:GraphicContainer = uiInstance.getElement("ctr_alignment_top") as GraphicContainer;
         var tx_alignment:Texture = uiInstance.getElement("tx_alignment") as Texture;
         var tx_alignmentBottom:Texture = uiInstance.getElement("tx_alignmentBottom") as Texture;
         if((data.hasOwnProperty("infos")) && (data.infos.hasOwnProperty("alignmentInfos")))
         {
            alignmentInfos = oParam.data.infos.alignmentInfos;
         }
         else if(data.hasOwnProperty("alignmentInfos"))
         {
            alignmentInfos = data.alignmentInfos;
         }
         
         if((alignmentInfos) && (alignmentInfos.alignmentSide > 0) && (alignmentInfos.alignmentGrade > 0))
         {
            w = tx_back.width / 2;
            ctr_alignment_bottom.x = w;
            ctr_alignment_top.x = w;
            ctr_alignment_bottom.y = tx_back.height - 4;
            ctr_alignment_top.addContent(tx_alignment);
            ctr_alignment_bottom.addContent(tx_alignmentBottom);
            tx_alignment.uri = Api.ui.createUri(alignmentUri + "wings.swf|demonAngel");
            tx_alignmentBottom.uri = Api.ui.createUri(alignmentUri + "wings.swf|demonAngel2");
            tx_alignment.cacheAsBitmap = true;
            tx_alignmentBottom.cacheAsBitmap = true;
            tx_alignment.gotoAndStop = (alignmentInfos.alignmentSide - 1) * 10 + 1 + alignmentInfos.alignmentGrade;
            tx_alignmentBottom.gotoAndStop = (alignmentInfos.alignmentSide - 1) * 10 + 1 + alignmentInfos.alignmentGrade;
            tx_alignment.filters = new Array();
            tx_alignmentBottom.filters = new Array();
            tx_alignment.transform.colorTransform = new ColorTransform(1,1,1);
            tx_alignmentBottom.transform.colorTransform = new ColorTransform(1,1,1);
            if(data.hasOwnProperty("wingsEffect"))
            {
               if(data.wingsEffect == -1)
               {
                  if(alignmentInfos.alignmentSide == 2)
                  {
                     tx_alignment.transform.colorTransform = new ColorTransform(0.6,0.6,0.6);
                     tx_alignmentBottom.transform.colorTransform = new ColorTransform(0.6,0.6,0.6);
                  }
                  else
                  {
                     tx_alignment.transform.colorTransform = new ColorTransform(0.7,0.7,0.7);
                     tx_alignmentBottom.transform.colorTransform = new ColorTransform(0.7,0.7,0.7);
                  }
               }
               else if(data.wingsEffect == 1)
               {
                  if(alignmentInfos.alignmentSide == 1)
                  {
                     tx_alignment.filters = new Array(new GlowFilter(16777215,1,5,5,1,3));
                     tx_alignmentBottom.filters = new Array(new GlowFilter(16777215,1,5,5,1,3));
                     tx_alignment.transform.colorTransform = new ColorTransform(1.1,1.1,1.2);
                     tx_alignmentBottom.transform.colorTransform = new ColorTransform(1.1,1.1,1.2);
                  }
                  else if(alignmentInfos.alignmentSide == 2)
                  {
                     tx_alignment.filters = new Array(new GlowFilter(16711704,1,10,10,2,3));
                     tx_alignmentBottom.filters = new Array(new GlowFilter(16711704,1,10,10,2,3));
                     tx_alignment.transform.colorTransform = new ColorTransform(1.2,1.1,1.1);
                     tx_alignmentBottom.transform.colorTransform = new ColorTransform(1.2,1.1,1.1);
                  }
                  else if(alignmentInfos.alignmentSide == 3)
                  {
                     tx_alignment.filters = new Array(new GlowFilter(16771761,1,5,5,1,3));
                     tx_alignmentBottom.filters = new Array(new GlowFilter(16771761,1,5,5,1,3));
                     tx_alignment.transform.colorTransform = new ColorTransform(1.2,1.2,1.1);
                     tx_alignmentBottom.transform.colorTransform = new ColorTransform(1.2,1.2,1.1);
                  }
                  
                  
               }
               
            }
         }
      }
   }
}
