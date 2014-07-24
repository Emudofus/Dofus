package blocks
{
   import d2hooks.*;
   
   public class ConditionTooltipBlock extends Object
   {
      
      public function ConditionTooltipBlock(conditions:Object, length:int, criteria:String, titleText:String = null, onTarget:Boolean = false) {
         super();
         this._conditions = conditions;
         this._criteria = criteria;
         this._length = length;
         this._onTarget = onTarget;
         if(titleText)
         {
            this._titleText = titleText;
         }
         else
         {
            this._titleText = Api.ui.getText("ui.common.conditions");
         }
         this._block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,this.getContent);
         this._block.initChunk([Api.tooltip.createChunkData("subTitle","chunks/base/subTitle.txt"),Api.tooltip.createChunkData("effect","chunks/effect/effect.txt")]);
      }
      
      private var _conditions:Object;
      
      private var _criteria:String;
      
      private var _content:String;
      
      private var _titleText:String;
      
      private var _length:int;
      
      private var _onTarget:Boolean;
      
      private var _block:Object;
      
      public function onAllChunkLoaded() : void {
         var criterion:Object = null;
         var index:uint = 0;
         var criteriaText:String = null;
         var criteriaRespected:* = false;
         var css:String = null;
         var ORindex:* = 0;
         var i:* = 0;
         var firstParenthesisIndex:* = 0;
         var logicOperatorIndex:* = 0;
         var newLineOperator:String = null;
         var inlineCriteria:Object = null;
         if((this._conditions == null) || (this._conditions.criteria == null) || (this._conditions.criteria.length == 0))
         {
            return;
         }
         var pattern0:RegExp = new RegExp("<","g");
         var pattern1:RegExp = new RegExp(">","g");
         this._content = this._block.getChunk("subTitle").processContent(
            {
               "text":this._titleText + Api.ui.getText("ui.common.colon"),
               "length":this._length
            });
         var tempContent:String = "";
         for each(criterion in this._conditions.criteria)
         {
            index = 0;
            criteriaText = "";
            criteriaRespected = criterion.isRespected;
            css = "p";
            ORindex = criterion.text.indexOf("|");
            firstParenthesisIndex = 0;
            logicOperatorIndex = 0;
            i = 0;
            while(i < criterion.inlineCriteria.length)
            {
               inlineCriteria = criterion.inlineCriteria[i];
               if(inlineCriteria.text != "")
               {
                  criteriaText = "";
                  if(index > 0)
                  {
                     if(ORindex > 0)
                     {
                        criteriaText = Api.ui.getText("ui.common.or") + " ";
                     }
                  }
                  if(this._onTarget)
                  {
                     criteriaText = "(" + Api.ui.getText("ui.item.target") + ") ";
                  }
                  if((!criteriaRespected) && (!inlineCriteria.isRespected))
                  {
                     css = "malus";
                  }
                  criteriaText = criteriaText + inlineCriteria.text;
                  if((criterion.inlineCriteria.length > 1) && (i == firstParenthesisIndex) && (!(criterion.operators.indexOf("|") == -1)))
                  {
                     criteriaText = "(" + criteriaText;
                  }
                  if(newLineOperator == "|")
                  {
                     criteriaText = Api.ui.getText("ui.common.or") + " " + criteriaText;
                     newLineOperator = "null";
                  }
                  if(criterion.inlineCriteria.length > 1)
                  {
                     if((!(i == firstParenthesisIndex)) && (i == criterion.inlineCriteria.length - 1) && (this._conditions.operators))
                     {
                        criteriaText = criteriaText + ")";
                        newLineOperator = this._conditions.operators[logicOperatorIndex];
                        logicOperatorIndex++;
                     }
                  }
                  else if((this._conditions.criteria.length > 1) && (this._conditions.operators))
                  {
                     if(this._conditions.operators[logicOperatorIndex] == "|")
                     {
                        newLineOperator = this._conditions.operators[logicOperatorIndex];
                        logicOperatorIndex++;
                     }
                  }
                  
                  index++;
               }
               else if(i == 0)
               {
                  firstParenthesisIndex++;
               }
               
               if(criteriaText != "")
               {
                  criteriaText = "• " + criteriaText;
               }
               criteriaText = criteriaText.replace(pattern0,"&lt;");
               criteriaText = criteriaText.replace(pattern1,"&gt;");
               if(criteriaText)
               {
                  tempContent = tempContent + this._block.getChunk("effect").processContent(
                     {
                        "text":criteriaText,
                        "cssClass":css,
                        "length":this._length
                     });
               }
               i++;
            }
         }
         if(tempContent == "")
         {
            this._content = "";
         }
         else
         {
            this._content = this._content + tempContent;
         }
      }
      
      public function getContent() : String {
         return this._content;
      }
      
      public function get block() : Object {
         return this._block;
      }
   }
}
