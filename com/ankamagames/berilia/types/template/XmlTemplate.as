package com.ankamagames.berilia.types.template
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.xml.XMLDocument;
   import flash.xml.XMLNode;
   import com.ankamagames.jerakine.eval.Evaluator;
   import com.ankamagames.berilia.enums.XmlTagsEnum;
   import com.ankamagames.berilia.enums.XmlAttributesEnum;
   
   public class XmlTemplate extends Object
   {
      
      public function XmlTemplate(sXml:String = null, sFilename:String = null) {
         this._aVariablesStack = new Array();
         super();
         this._filename = sFilename;
         if(sXml != null)
         {
            this.xml = sXml;
         }
      }
      
      protected static const _log:Logger;
      
      private var _aTemplateParams:Array;
      
      private var _sXml:String;
      
      private var _xDoc:XMLDocument;
      
      private var _aVariablesStack:Array;
      
      private var _filename:String;
      
      public function get xml() : String {
         return this._sXml;
      }
      
      public function set xml(sXml:String) : void {
         this._sXml = sXml;
         this.parseTemplate();
      }
      
      public function get filename() : String {
         return this._filename;
      }
      
      public function set filename(s:String) : void {
         this._filename = s;
      }
      
      public function get templateParams() : Array {
         return this._aTemplateParams;
      }
      
      public function get variablesStack() : Array {
         return this._aVariablesStack;
      }
      
      public function makeTemplate(aVar:Array) : XMLNode {
         var key:String = null;
         var aVariables:Array = null;
         var variable:TemplateVar = null;
         var step:uint = 0;
         var evaluator:Evaluator = new Evaluator();
         var newXml:String = this._xDoc.toString();
         var localVar:Array = [];
         for(key in this._aTemplateParams)
         {
            localVar[key] = this._aTemplateParams[key];
         }
         for(key in aVar)
         {
            if(!this._aTemplateParams[key])
            {
               _log.error("Template " + this._filename + ", param " + key + " is not defined");
               delete aVar[key];
            }
            else
            {
               localVar[key] = aVar[key];
            }
         }
         newXml = this.replaceParam(newXml,localVar,"#");
         aVariables = new Array();
         step = 0;
         while(step < this._aVariablesStack.length)
         {
            variable = this._aVariablesStack[step].clone();
            variable.value = evaluator.eval(this.replaceParam(this.replaceParam(variable.value,localVar,"#"),aVariables,"$"));
            aVariables[variable.name] = variable;
            step++;
         }
         newXml = this.replaceParam(newXml,aVariables,"$");
         var newDoc:XMLDocument = new XMLDocument();
         newDoc.parseXML(newXml);
         return newDoc;
      }
      
      private function parseTemplate() : void {
         this._xDoc = new XMLDocument();
         this._aTemplateParams = new Array();
         this._xDoc.ignoreWhite = true;
         this._xDoc.parseXML(this._sXml);
         if(this._xDoc.firstChild.nodeName + ".xml" != this._filename)
         {
            _log.error("Wrong root node name in " + this._filename + ", found " + this._xDoc.firstChild.nodeName + ", waiting for " + this._filename.replace(".xml",""));
            return;
         }
         this.matchDynamicsParts(this._xDoc.firstChild);
      }
      
      private function matchDynamicsParts(node:XMLNode) : void {
         var currNode:XMLNode = null;
         var variable:TemplateVar = null;
         var param:TemplateParam = null;
         var i:uint = 0;
         for(;i < node.childNodes.length;i++)
         {
            currNode = node.childNodes[i];
            if(currNode.nodeName == XmlTagsEnum.TAG_VAR)
            {
               if(currNode.attributes[XmlAttributesEnum.ATTRIBUTE_NAME])
               {
                  variable = new TemplateVar(currNode.attributes[XmlAttributesEnum.ATTRIBUTE_NAME]);
                  variable.value = currNode.firstChild.toString().replace(new RegExp("&apos;","g"),"\'");
                  this._aVariablesStack.push(variable);
                  currNode.removeNode();
                  i--;
                  continue;
               }
               _log.warn(currNode.nodeName + " must have [" + XmlAttributesEnum.ATTRIBUTE_NAME + "] attribute");
            }
            if(currNode.nodeName == XmlTagsEnum.TAG_PARAM)
            {
               if(currNode.attributes[XmlAttributesEnum.ATTRIBUTE_NAME])
               {
                  param = new TemplateParam(currNode.attributes[XmlAttributesEnum.ATTRIBUTE_NAME]);
                  this._aTemplateParams[param.name] = param;
                  if(currNode.hasChildNodes())
                  {
                     param.defaultValue = currNode.firstChild.toString();
                  }
                  else
                  {
                     param.defaultValue = "";
                  }
                  currNode.removeNode();
                  i--;
               }
               else
               {
                  _log.warn(currNode.nodeName + " must have [" + XmlAttributesEnum.ATTRIBUTE_NAME + "] attribute");
               }
            }
         }
      }
      
      private function replaceParam(txt:String, aVars:Array, prefix:String, recur:uint = 1) : String {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
