package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   
   public class GroupItemCriterion extends Object implements IItemCriterion, IDataCenter
   {
      
      public function GroupItemCriterion(param1:String) {
         super();
         this._criterionTextForm = param1;
         this._cleanCriterionTextForm = this._criterionTextForm;
         if(!param1)
         {
            return;
         }
         this._cleanCriterionTextForm = StringUtils.replace(this._cleanCriterionTextForm," ","");
         var _loc2_:Vector.<String> = StringUtils.getDelimitedText(this._cleanCriterionTextForm,"(",")",true);
         if(_loc2_.length > 0 && _loc2_[0] == this._cleanCriterionTextForm)
         {
            this._cleanCriterionTextForm = this._cleanCriterionTextForm.slice(1);
            this._cleanCriterionTextForm = this._cleanCriterionTextForm.slice(0,this._cleanCriterionTextForm.length-1);
         }
         this.split();
         this.createNewGroups();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GroupItemCriterion));
      
      public static function create(param1:Vector.<IItemCriterion>, param2:Vector.<String>) : GroupItemCriterion {
         var _loc9_:* = undefined;
         var _loc3_:uint = param1.length + param2.length;
         var _loc4_:* = "";
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         while(_loc7_ < _loc3_)
         {
            _loc9_ = _loc7_ % 2;
            if(_loc9_ == 0)
            {
               _loc4_ = _loc4_ + (param1[_loc5_++] as IItemCriterion).basicText;
            }
            else
            {
               _loc4_ = _loc4_ + param2[_loc6_++];
            }
            _loc7_++;
         }
         var _loc8_:GroupItemCriterion = new GroupItemCriterion(_loc4_);
         return _loc8_;
      }
      
      private var _criteria:Vector.<IItemCriterion>;
      
      private var _operators:Vector.<String>;
      
      private var _criterionTextForm:String;
      
      private var _cleanCriterionTextForm:String;
      
      private var _malformated:Boolean = false;
      
      private var _singleOperatorType:Boolean = false;
      
      public function get criteria() : Vector.<IItemCriterion> {
         return this._criteria;
      }
      
      public function get inlineCriteria() : Vector.<IItemCriterion> {
         var _loc2_:IItemCriterion = null;
         var _loc1_:Vector.<IItemCriterion> = new Vector.<IItemCriterion>();
         for each (_loc2_ in this._criteria)
         {
            _loc1_ = _loc1_.concat(_loc2_.inlineCriteria);
         }
         return _loc1_;
      }
      
      public function get isRespected() : Boolean {
         var _loc2_:IItemCriterion = null;
         if(!this._criteria || this._criteria.length == 0)
         {
            return true;
         }
         var _loc1_:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         if(!_loc1_ || !_loc1_.characteristics)
         {
            return true;
         }
         if((this._criteria) && (this._criteria.length == 1) && this._criteria[0] is ItemCriterion)
         {
            return (this._criteria[0] as ItemCriterion).isRespected;
         }
         if(this._operators[0] == "|")
         {
            for each (_loc2_ in this._criteria)
            {
               if(_loc2_.isRespected)
               {
                  return true;
               }
            }
            return false;
         }
         for each (_loc2_ in this._criteria)
         {
            if(!_loc2_.isRespected)
            {
               return false;
            }
         }
         return true;
      }
      
      public function get text() : String {
         var _loc6_:* = undefined;
         var _loc1_:* = "";
         if(this._criteria == null)
         {
            return _loc1_;
         }
         var _loc2_:uint = this._criteria.length + this._operators.length;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc2_)
         {
            _loc6_ = _loc5_ % 2;
            if(_loc6_ == 0)
            {
               _loc1_ = _loc1_ + (this._criteria[_loc3_++] as IItemCriterion).text + " ";
            }
            else
            {
               _loc1_ = _loc1_ + this._operators[_loc4_++] + " ";
            }
            _loc5_++;
         }
         return _loc1_;
      }
      
      public function get basicText() : String {
         return this._criterionTextForm;
      }
      
      public function clone() : IItemCriterion {
         var _loc1_:IItemCriterion = new GroupItemCriterion(this.basicText);
         return _loc1_;
      }
      
      private function createNewGroups() : void {
         var _loc3_:IItemCriterion = null;
         var _loc4_:String = null;
         var _loc5_:* = 0;
         var _loc6_:* = false;
         var _loc7_:Vector.<IItemCriterion> = null;
         var _loc8_:Vector.<String> = null;
         var _loc9_:GroupItemCriterion = null;
         if((this._malformated) || !this._criteria || this._criteria.length <= 2 || (this._singleOperatorType))
         {
            return;
         }
         var _loc1_:Vector.<IItemCriterion> = new Vector.<IItemCriterion>();
         var _loc2_:Vector.<String> = new Vector.<String>();
         for each (_loc3_ in this._criteria)
         {
            _loc1_.push(_loc3_.clone());
         }
         for each (_loc4_ in this._operators)
         {
            _loc2_.push(_loc4_);
         }
         _loc5_ = 0;
         _loc6_ = false;
         while(!_loc6_)
         {
            if(_loc1_.length <= 2)
            {
               _loc6_ = true;
            }
            else
            {
               if(_loc2_[_loc5_] == "&")
               {
                  _loc7_ = new Vector.<IItemCriterion>();
                  _loc7_.push(_loc1_[_loc5_]);
                  _loc7_.push(_loc1_[_loc5_ + 1]);
                  _loc8_ = Vector.<String>([_loc2_[_loc5_]]);
                  _loc9_ = GroupItemCriterion.create(_loc7_,_loc8_);
                  _loc1_.splice(_loc5_,2,_loc9_);
                  _loc2_.splice(_loc5_,1);
                  _loc5_--;
               }
               _loc5_++;
               if(_loc5_ >= _loc2_.length)
               {
                  _loc6_ = true;
               }
            }
         }
         this._criteria = _loc1_;
         this._operators = _loc2_;
         this._singleOperatorType = this.checkSingleOperatorType(this._operators);
      }
      
      private function split() : void {
         var _loc8_:IItemCriterion = null;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:String = null;
         var _loc12_:IItemCriterion = null;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:String = null;
         var _loc16_:String = null;
         var _loc17_:String = null;
         if(!this._cleanCriterionTextForm)
         {
            return;
         }
         var _loc1_:uint = 0;
         var _loc2_:uint = 1;
         var _loc3_:uint = _loc1_;
         var _loc4_:* = false;
         var _loc5_:String = this._cleanCriterionTextForm;
         this._criteria = new Vector.<IItemCriterion>();
         this._operators = new Vector.<String>();
         var _loc6_:Array = StringUtils.getAllIndexOf("&",_loc5_);
         var _loc7_:Array = StringUtils.getAllIndexOf("|",_loc5_);
         if(_loc6_.length == 0 || _loc7_.length == 0)
         {
            this._singleOperatorType = true;
            while(!_loc4_)
            {
               _loc8_ = this.getFirstCriterion(_loc5_);
               if(!_loc8_)
               {
                  _loc9_ = _loc5_.indexOf("&");
                  if(_loc9_ == -1)
                  {
                     _loc9_ = _loc5_.indexOf("|");
                  }
                  if(_loc9_ == -1)
                  {
                     _loc5_ = "";
                  }
                  else
                  {
                     _loc5_ = _loc5_.slice(_loc9_ + 1);
                  }
               }
               else
               {
                  this._criteria.push(_loc8_);
                  _loc10_ = _loc5_.indexOf(_loc8_.basicText);
                  _loc11_ = _loc5_.slice(_loc10_ + _loc8_.basicText.length,_loc10_ + 1 + _loc8_.basicText.length);
                  if(_loc11_)
                  {
                     this._operators.push(_loc11_);
                  }
                  _loc5_ = _loc5_.slice(_loc10_ + 1 + _loc8_.basicText.length);
               }
               if(!_loc5_)
               {
                  _loc4_ = true;
               }
            }
         }
         else
         {
            while(!_loc4_)
            {
               if(!_loc5_)
               {
                  _loc4_ = true;
               }
               else
               {
                  if(_loc3_ == _loc1_)
                  {
                     _loc12_ = this.getFirstCriterion(_loc5_);
                     if(!_loc12_)
                     {
                        _loc13_ = _loc5_.indexOf("&");
                        if(_loc13_ == -1)
                        {
                           _loc13_ = _loc5_.indexOf("|");
                        }
                        if(_loc13_ == -1)
                        {
                           _loc5_ = "";
                        }
                        else
                        {
                           _loc5_ = _loc5_.slice(_loc13_ + 1);
                        }
                     }
                     else
                     {
                        this._criteria.push(_loc12_);
                        _loc3_ = _loc2_;
                        _loc14_ = _loc5_.indexOf(_loc12_.basicText);
                        _loc15_ = _loc5_.slice(0,_loc14_);
                        _loc16_ = _loc5_.slice(_loc14_ + _loc12_.basicText.length);
                        _loc5_ = _loc15_ + _loc16_;
                     }
                     if(!_loc5_)
                     {
                        _loc4_ = true;
                     }
                  }
                  else
                  {
                     _loc17_ = _loc5_.slice(0,1);
                     if(!_loc17_)
                     {
                        _loc4_ = true;
                     }
                     else
                     {
                        this._operators.push(_loc17_);
                        _loc3_ = _loc1_;
                        _loc5_ = _loc5_.slice(1);
                     }
                  }
               }
            }
            this._singleOperatorType = this.checkSingleOperatorType(this._operators);
         }
         if(this._operators.length >= this._criteria.length && this._operators.length > 0 && this._criteria.length > 0)
         {
            this._malformated = true;
         }
      }
      
      private function checkSingleOperatorType(param1:Vector.<String>) : Boolean {
         var _loc2_:String = null;
         if(param1.length > 0)
         {
            for each (_loc2_ in param1)
            {
               if(_loc2_ != param1[0])
               {
                  return false;
               }
            }
         }
         return true;
      }
      
      private function getFirstCriterion(param1:String) : IItemCriterion {
         var _loc2_:IItemCriterion = null;
         var _loc3_:Vector.<String> = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         if(!param1)
         {
            return null;
         }
         var param1:String = StringUtils.replace(param1," ","");
         if(param1.slice(0,1) == "(")
         {
            _loc3_ = StringUtils.getDelimitedText(param1,"(",")",true);
            _loc2_ = new GroupItemCriterion(_loc3_[0]);
         }
         else
         {
            _loc4_ = param1.indexOf("&");
            _loc5_ = param1.indexOf("|");
            if(_loc4_ == -1 && _loc5_ == -1)
            {
               _loc2_ = ItemCriterionFactory.create(param1);
            }
            else
            {
               if((_loc4_ < _loc5_ || _loc5_ == -1) && !(_loc4_ == -1))
               {
                  _loc2_ = ItemCriterionFactory.create(param1.split("&")[0]);
               }
               else
               {
                  _loc2_ = ItemCriterionFactory.create(param1.split("|")[0]);
               }
            }
         }
         return _loc2_;
      }
      
      public function get operators() : Vector.<String> {
         return this._operators;
      }
   }
}
