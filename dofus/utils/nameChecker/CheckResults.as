// Action script...

// [Initial MovieClip Action of sprite 20741]
#initclip 6
if (!dofus.utils.nameChecker.CheckResults)
{
    if (!dofus)
    {
        _global.dofus = new Object();
    } // end if
    if (!dofus.utils)
    {
        _global.dofus.utils = new Object();
    } // end if
    if (!dofus.utils.nameChecker)
    {
        _global.dofus.utils.nameChecker = new Object();
    } // end if
    var _loc1 = (_global.dofus.utils.nameChecker.CheckResults = function ()
    {
        super();
    }).prototype;
    _loc1.toString = function (sJoin)
    {
        var _loc3 = new String();
        if (this.IS_SUCCESS)
        {
            _loc3 = "OK!";
        }
        else if (this.api.lang.getText != undefined)
        {
            var _loc4 = new Array();
            if (this.FAILED_ON_LENGTH_CHECK)
            {
                _loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_3"));
            } // end if
            if (this.FAILED_ON_SPACES_CHECK)
            {
                _loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_11"));
            } // end if
            if (this.FAILED_ON_DASHES_AT_INDEXES_CHECK)
            {
                _loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_1"));
            } // end if
            if (this.FAILED_ON_DASHES_COUNT_CHECK)
            {
                _loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_2"));
            } // end if
            if (this.FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK)
            {
                _loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_4"));
            } // end if
            if (this.FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK)
            {
                _loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_5"));
            } // end if
            if (this.FAILED_ON_UPPERCASE_AT_THE_END_CHECK)
            {
                _loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_6"));
            } // end if
            if (this.FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK)
            {
                _loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_7"));
            } // end if
            if (this.FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK)
            {
                _loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_8"));
            } // end if
            if (this.FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK)
            {
                _loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_9"));
            } // end if
            if (this.FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK)
            {
                _loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_10"));
            } // end if
            if (this.FAILED_ON_VOWELS_COUNT_CHECK)
            {
                _loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_12"));
            } // end if
            if (this.FAILED_ON_CONSONANTS_COUNT_CHECK)
            {
                _loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_13"));
            } // end if
            if (this.FAILED_ON_REPETITION_CHECK)
            {
                _loc4.push(this.api.lang.getText("CHARACTER_NAME_ERROR_14"));
            } // end if
            _loc3 = _loc4.join(sJoin);
        }
        else
        {
            var _loc5 = new Array();
            if (this.FAILED_ON_LENGTH_CHECK)
            {
                _loc5.push("FAILED_ON_LENGTH_CHECK");
            } // end if
            if (this.FAILED_ON_SPACES_CHECK)
            {
                _loc5.push("FAILED_ON_SPACES_CHECK");
            } // end if
            if (this.FAILED_ON_DASHES_AT_INDEXES_CHECK)
            {
                _loc5.push("FAILED_ON_DASHES_AT_INDEXES_CHECK");
            } // end if
            if (this.FAILED_ON_DASHES_COUNT_CHECK)
            {
                _loc5.push("FAILED_ON_DASHES_COUNT_CHECK");
            } // end if
            if (this.FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK)
            {
                _loc5.push("FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK");
            } // end if
            if (this.FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK)
            {
                _loc5.push("FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK");
            } // end if
            if (this.FAILED_ON_UPPERCASE_AT_THE_END_CHECK)
            {
                _loc5.push("FAILED_ON_UPPERCASE_AT_THE_END_CHECK");
            } // end if
            if (this.FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK)
            {
                _loc5.push("FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK");
            } // end if
            if (this.FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK)
            {
                _loc5.push("FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK");
            } // end if
            if (this.FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK)
            {
                _loc5.push("FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK");
            } // end if
            if (this.FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK)
            {
                _loc5.push("FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK");
            } // end if
            if (this.FAILED_ON_VOWELS_COUNT_CHECK)
            {
                _loc5.push("FAILED_ON_VOWELS_COUNT_CHECK");
            } // end if
            if (this.FAILED_ON_CONSONANTS_COUNT_CHECK)
            {
                _loc5.push("FAILED_ON_CONSONANTS_COUNT_CHECK");
            } // end if
            if (this.FAILED_ON_REPETITION_CHECK)
            {
                _loc5.push("FAILED_ON_REPETITION_CHECK");
            } // end if
            _loc3 = _loc5.join(sJoin);
        } // end else if
        return (_loc3);
    };
    _loc1.errorCount = function ()
    {
        var _loc2 = 0;
        if (this.FAILED_ON_LENGTH_CHECK)
        {
            ++_loc2;
        } // end if
        if (this.FAILED_ON_SPACES_CHECK)
        {
            ++_loc2;
        } // end if
        if (this.FAILED_ON_DASHES_AT_INDEXES_CHECK)
        {
            ++_loc2;
        } // end if
        if (this.FAILED_ON_DASHES_COUNT_CHECK)
        {
            ++_loc2;
        } // end if
        if (this.FAILED_ON_UPPERCASE_FIRST_CHAR_CHECK)
        {
            ++_loc2;
        } // end if
        if (this.FAILED_ON_UPPERCASE_AFTER_THE_FIRST_CHECK)
        {
            ++_loc2;
        } // end if
        if (this.FAILED_ON_UPPERCASE_AT_THE_END_CHECK)
        {
            ++_loc2;
        } // end if
        if (this.FAILED_ON_STRICTLY_EQUALS_PROHIBED_WORDS_CHECK)
        {
            ++_loc2;
        } // end if
        if (this.FAILED_ON_CONTAINING_PROHIBED_WORDS_CHECK)
        {
            ++_loc2;
        } // end if
        if (this.FAILED_ON_BEGINNING_WITH_PROHIBED_WORDS_CHECK)
        {
            ++_loc2;
        } // end if
        if (this.FAILED_ON_ENDING_WITH_PROHIBED_WORDS_CHECK)
        {
            ++_loc2;
        } // end if
        if (this.FAILED_ON_VOWELS_COUNT_CHECK)
        {
            ++_loc2;
        } // end if
        if (this.FAILED_ON_CONSONANTS_COUNT_CHECK)
        {
            ++_loc2;
        } // end if
        if (this.FAILED_ON_REPETITION_CHECK)
        {
            ++_loc2;
        } // end if
        return (_loc2);
    };
    ASSetPropFlags(_loc1, null, 1);
} // end if
#endinitclip
