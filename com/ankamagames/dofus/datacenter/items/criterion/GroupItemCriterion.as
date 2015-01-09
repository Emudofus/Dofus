package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.utils.misc.StringUtils;
    import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
    import __AS3__.vec.*;

    public class GroupItemCriterion implements IItemCriterion, IDataCenter 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GroupItemCriterion));

        private var _criteria:Vector.<IItemCriterion>;
        private var _operators:Vector.<String>;
        private var _criterionTextForm:String;
        private var _cleanCriterionTextForm:String;
        private var _malformated:Boolean = false;
        private var _singleOperatorType:Boolean = false;

        public function GroupItemCriterion(pCriterion:String)
        {
            this._criterionTextForm = pCriterion;
            this._cleanCriterionTextForm = this._criterionTextForm;
            if (!(pCriterion))
            {
                return;
            };
            this._cleanCriterionTextForm = StringUtils.replace(this._cleanCriterionTextForm, " ", "");
            var delimitedArray:Vector.<String> = StringUtils.getDelimitedText(this._cleanCriterionTextForm, "(", ")", true);
            if ((((delimitedArray.length > 0)) && ((delimitedArray[0] == this._cleanCriterionTextForm))))
            {
                this._cleanCriterionTextForm = this._cleanCriterionTextForm.slice(1);
                this._cleanCriterionTextForm = this._cleanCriterionTextForm.slice(0, (this._cleanCriterionTextForm.length - 1));
            };
            this.split();
            this.createNewGroups();
        }

        public static function create(pCriteria:Vector.<IItemCriterion>, pOperators:Vector.<String>):GroupItemCriterion
        {
            var pair:*;
            var tabLength:uint = (pCriteria.length + pOperators.length);
            var textForm:String = "";
            var criterionIndex:uint;
            var operatorIndex:uint;
            var i:uint;
            while (i < tabLength)
            {
                pair = (i % 2);
                if (pair == 0)
                {
                    textForm = (textForm + (pCriteria[criterionIndex++] as IItemCriterion).basicText);
                }
                else
                {
                    textForm = (textForm + pOperators[operatorIndex++]);
                };
                i++;
            };
            var group:GroupItemCriterion = new (GroupItemCriterion)(textForm);
            return (group);
        }


        public function get criteria():Vector.<IItemCriterion>
        {
            return (this._criteria);
        }

        public function get inlineCriteria():Vector.<IItemCriterion>
        {
            var criterion:IItemCriterion;
            var criteria:Vector.<IItemCriterion> = new Vector.<IItemCriterion>();
            for each (criterion in this._criteria)
            {
                criteria = criteria.concat(criterion.inlineCriteria);
            };
            return (criteria);
        }

        public function get isRespected():Boolean
        {
            var criterion:IItemCriterion;
            if (((!(this._criteria)) || ((this._criteria.length == 0))))
            {
                return (true);
            };
            var player:PlayedCharacterManager = PlayedCharacterManager.getInstance();
            if (((!(player)) || (!(player.characteristics))))
            {
                return (true);
            };
            if (((((this._criteria) && ((this._criteria.length == 1)))) && ((this._criteria[0] is ItemCriterion))))
            {
                return ((this._criteria[0] as ItemCriterion).isRespected);
            };
            if (this._operators[0] == "|")
            {
                for each (criterion in this._criteria)
                {
                    if (criterion.isRespected)
                    {
                        return (true);
                    };
                };
                return (false);
            };
            for each (criterion in this._criteria)
            {
                if (!(criterion.isRespected))
                {
                    return (false);
                };
            };
            return (true);
        }

        public function get text():String
        {
            var pair:*;
            var textForm:String = "";
            if (this._criteria == null)
            {
                return (textForm);
            };
            var tabLength:uint = (this._criteria.length + this._operators.length);
            var criterionIndex:uint;
            var operatorIndex:uint;
            var i:uint;
            while (i < tabLength)
            {
                pair = (i % 2);
                if (pair == 0)
                {
                    textForm = ((textForm + (this._criteria[criterionIndex++] as IItemCriterion).text) + " ");
                }
                else
                {
                    textForm = ((textForm + this._operators[operatorIndex++]) + " ");
                };
                i++;
            };
            return (textForm);
        }

        public function get basicText():String
        {
            return (this._criterionTextForm);
        }

        public function clone():IItemCriterion
        {
            var clonedCriterion:IItemCriterion = new GroupItemCriterion(this.basicText);
            return (clonedCriterion);
        }

        private function createNewGroups():void
        {
            var crit:IItemCriterion;
            var ope:String;
            var curIndex:int;
            var exit:Boolean;
            var crits:Vector.<IItemCriterion>;
            var ops:Vector.<String>;
            var group:GroupItemCriterion;
            if (((((((this._malformated) || (!(this._criteria)))) || ((this._criteria.length <= 2)))) || (this._singleOperatorType)))
            {
                return;
            };
            var copyCriteria:Vector.<IItemCriterion> = new Vector.<IItemCriterion>();
            var copyOperators:Vector.<String> = new Vector.<String>();
            for each (crit in this._criteria)
            {
                copyCriteria.push(crit.clone());
            };
            for each (ope in this._operators)
            {
                copyOperators.push(ope);
            };
            curIndex = 0;
            exit = false;
            while (!(exit))
            {
                if (copyCriteria.length <= 2)
                {
                    exit = true;
                }
                else
                {
                    if (copyOperators[curIndex] == "&")
                    {
                        crits = new Vector.<IItemCriterion>();
                        crits.push(copyCriteria[curIndex]);
                        crits.push(copyCriteria[(curIndex + 1)]);
                        ops = Vector.<String>([copyOperators[curIndex]]);
                        group = GroupItemCriterion.create(crits, ops);
                        copyCriteria.splice(curIndex, 2, group);
                        copyOperators.splice(curIndex, 1);
                        curIndex--;
                    };
                    curIndex++;
                    if (curIndex >= copyOperators.length)
                    {
                        exit = true;
                    };
                };
            };
            this._criteria = copyCriteria;
            this._operators = copyOperators;
            this._singleOperatorType = this.checkSingleOperatorType(this._operators);
        }

        private function split():void
        {
            var criterion:IItemCriterion;
            var indexOfNextCriterion:int;
            var _local_10:int;
            var _local_11:String;
            var criterion2:IItemCriterion;
            var indexOfNextCriterion2:int;
            var _local_14:int;
            var _local_15:String;
            var _local_16:String;
            var _local_17:String;
            if (!(this._cleanCriterionTextForm))
            {
                return;
            };
            var CRITERION:uint;
            var OPERATOR:uint = 1;
            var next:uint = CRITERION;
            var exit:Boolean;
            var searchingString:String = this._cleanCriterionTextForm;
            this._criteria = new Vector.<IItemCriterion>();
            this._operators = new Vector.<String>();
            var andIndexes:Array = StringUtils.getAllIndexOf("&", searchingString);
            var orIndexes:Array = StringUtils.getAllIndexOf("|", searchingString);
            if ((((andIndexes.length == 0)) || ((orIndexes.length == 0))))
            {
                this._singleOperatorType = true;
                while (!(exit))
                {
                    criterion = this.getFirstCriterion(searchingString);
                    if (!(criterion))
                    {
                        indexOfNextCriterion = searchingString.indexOf("&");
                        if (indexOfNextCriterion == -1)
                        {
                            indexOfNextCriterion = searchingString.indexOf("|");
                        };
                        if (indexOfNextCriterion == -1)
                        {
                            searchingString = "";
                        }
                        else
                        {
                            searchingString = searchingString.slice((indexOfNextCriterion + 1));
                        };
                    }
                    else
                    {
                        this._criteria.push(criterion);
                        _local_10 = searchingString.indexOf(criterion.basicText);
                        _local_11 = searchingString.slice((_local_10 + criterion.basicText.length), ((_local_10 + 1) + criterion.basicText.length));
                        if (_local_11)
                        {
                            this._operators.push(_local_11);
                        };
                        searchingString = searchingString.slice(((_local_10 + 1) + criterion.basicText.length));
                    };
                    if (!(searchingString))
                    {
                        exit = true;
                    };
                };
            }
            else
            {
                while (!(exit))
                {
                    if (!(searchingString))
                    {
                        exit = true;
                    }
                    else
                    {
                        if (next == CRITERION)
                        {
                            criterion2 = this.getFirstCriterion(searchingString);
                            if (!(criterion2))
                            {
                                indexOfNextCriterion2 = searchingString.indexOf("&");
                                if (indexOfNextCriterion2 == -1)
                                {
                                    indexOfNextCriterion2 = searchingString.indexOf("|");
                                };
                                if (indexOfNextCriterion2 == -1)
                                {
                                    searchingString = "";
                                }
                                else
                                {
                                    searchingString = searchingString.slice((indexOfNextCriterion2 + 1));
                                };
                            }
                            else
                            {
                                this._criteria.push(criterion2);
                                next = OPERATOR;
                                _local_14 = searchingString.indexOf(criterion2.basicText);
                                _local_15 = searchingString.slice(0, _local_14);
                                _local_16 = searchingString.slice((_local_14 + criterion2.basicText.length));
                                searchingString = (_local_15 + _local_16);
                            };
                            if (!(searchingString))
                            {
                                exit = true;
                            };
                        }
                        else
                        {
                            _local_17 = searchingString.slice(0, 1);
                            if (!(_local_17))
                            {
                                exit = true;
                            }
                            else
                            {
                                this._operators.push(_local_17);
                                next = CRITERION;
                                searchingString = searchingString.slice(1);
                            };
                        };
                    };
                };
                this._singleOperatorType = this.checkSingleOperatorType(this._operators);
            };
            if ((((this._operators.length >= this._criteria.length)) && ((((this._operators.length > 0)) && ((this._criteria.length > 0))))))
            {
                this._malformated = true;
                trace((((("Il y a un soucis avec le nombre d'opérateurs et de critères :/ " + this._operators.length) + " opérateur(s) pour ") + this._criteria.length) + " cirtère(s)"));
            };
        }

        private function checkSingleOperatorType(pOperators:Vector.<String>):Boolean
        {
            var op:String;
            if (pOperators.length > 0)
            {
                for each (op in pOperators)
                {
                    if (op != pOperators[0])
                    {
                        return (false);
                    };
                };
            };
            return (true);
        }

        private function getFirstCriterion(pCriteria:String):IItemCriterion
        {
            var criterion:IItemCriterion;
            var dl:Vector.<String>;
            var _local_4:int;
            var _local_5:int;
            if (!(pCriteria))
            {
                return (null);
            };
            pCriteria = StringUtils.replace(pCriteria, " ", "");
            if (pCriteria.slice(0, 1) == "(")
            {
                dl = StringUtils.getDelimitedText(pCriteria, "(", ")", true);
                criterion = new GroupItemCriterion(dl[0]);
            }
            else
            {
                _local_4 = pCriteria.indexOf("&");
                _local_5 = pCriteria.indexOf("|");
                if ((((_local_4 == -1)) && ((_local_5 == -1))))
                {
                    criterion = ItemCriterionFactory.create(pCriteria);
                }
                else
                {
                    if ((((((_local_4 < _local_5)) || ((_local_5 == -1)))) && (!((_local_4 == -1)))))
                    {
                        criterion = ItemCriterionFactory.create(pCriteria.split("&")[0]);
                    }
                    else
                    {
                        criterion = ItemCriterionFactory.create(pCriteria.split("|")[0]);
                    };
                };
            };
            return (criterion);
        }

        public function get operators():Vector.<String>
        {
            return (this._operators);
        }


    }
}//package com.ankamagames.dofus.datacenter.items.criterion

