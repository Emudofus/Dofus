// Action script...

// [Initial MovieClip Action of sprite 20633]
#initclip 154
if (!org.utils.SimpleDateFormatter)
{
    if (!org)
    {
        _global.org = new Object();
    } // end if
    if (!org.utils)
    {
        _global.org.utils = new Object();
    } // end if
    var _loc1 = (_global.org.utils.SimpleDateFormatter = function ()
    {
    }).prototype;
    (_global.org.utils.SimpleDateFormatter = function ()
    {
    }).LZ = function (x)
    {
        return ((x < 0 || x > 9 ? ("") : ("0")) + x);
    };
    (_global.org.utils.SimpleDateFormatter = function ()
    {
    }).formatDate = function (date, format, language)
    {
        if (language == undefined)
        {
            language = "en";
        } // end if
        format = format + "";
        var _loc5 = "";
        var _loc6 = 0;
        var _loc7 = "";
        var _loc8 = "";
        var _loc9 = date.getYear() + "";
        var _loc10 = date.getMonth() + 1;
        var _loc11 = date.getDate();
        var _loc12 = date.getDay();
        var _loc13 = date.getHours();
        var _loc14 = date.getMinutes();
        var _loc15 = date.getSeconds();
        var _loc16 = date.getMilliseconds();
        var _loc17 = new Object();
        if (_loc9.length < 4)
        {
            _loc9 = "" + (_loc9 - 0 + 1900);
        } // end if
        _loc17.y = "" + _loc9;
        _loc17.yyyy = _loc9;
        _loc17.yy = _loc9.substring(2, 4);
        _loc17.M = _loc10;
        _loc17.MM = org.utils.SimpleDateFormatter.LZ(_loc10);
        _loc17.MMM = org.utils.SimpleDateFormatter.MONTH_NAMES[language][_loc10 - 1];
        _loc17.NNN = org.utils.SimpleDateFormatter.MONTH_NAMES[language][_loc10 + 11];
        _loc17.d = _loc11;
        _loc17.dd = org.utils.SimpleDateFormatter.LZ(_loc11);
        _loc17.E = org.utils.SimpleDateFormatter.DAY_NAMES[language][_loc12 + 7];
        _loc17.EE = org.utils.SimpleDateFormatter.DAY_NAMES[language][_loc12];
        _loc17.H = _loc13;
        _loc17.HH = org.utils.SimpleDateFormatter.LZ(_loc13);
        if (_loc13 == 0)
        {
            _loc17.h = 12;
        }
        else if (_loc13 > 12)
        {
            _loc17.h = _loc13 - 12;
        }
        else
        {
            _loc17.h = _loc13;
        } // end else if
        _loc17.hh = org.utils.SimpleDateFormatter.LZ(_loc17.h);
        if (_loc13 > 11)
        {
            _loc17.K = _loc13 - 12;
        }
        else
        {
            _loc17.K = _loc13;
        } // end else if
        _loc17.k = _loc13 + 1;
        _loc17.KK = org.utils.SimpleDateFormatter.LZ(_loc17.K);
        _loc17.kk = org.utils.SimpleDateFormatter.LZ(_loc17.k);
        if (_loc13 > 11)
        {
            _loc17.a = "PM";
        }
        else
        {
            _loc17.a = "AM";
        } // end else if
        _loc17.m = _loc14;
        _loc17.mm = org.utils.SimpleDateFormatter.LZ(_loc14);
        _loc17.s = _loc15;
        _loc17.ss = org.utils.SimpleDateFormatter.LZ(_loc15);
        _loc17.i = _loc16;
        _loc17.ii = org.utils.SimpleDateFormatter.LZ(_loc16);
        while (_loc6 < format.length)
        {
            _loc7 = format.charAt(_loc6);
            for (var _loc8 = ""; format.charAt(_loc6) == _loc7 && _loc6 < format.length; _loc8 = _loc8 + format.charAt(_loc6++))
            {
            } // end of for
            if (_loc17[_loc8] != null)
            {
                _loc5 = _loc5 + _loc17[_loc8];
                continue;
            } // end if
            _loc5 = _loc5 + _loc8;
        } // end while
        return (_loc5);
    };
    (_global.org.utils.SimpleDateFormatter = function ()
    {
    }).isDate = function (val, format, language)
    {
        var _loc5 = org.utils.SimpleDateFormatter.getDateFromFormat(val, format, language);
        if (_loc5 == 0)
        {
            return (false);
        } // end if
        return (true);
    };
    (_global.org.utils.SimpleDateFormatter = function ()
    {
    }).compareDates = function (date1, dateformat1, language1, date2, dateformat2, language2)
    {
        var _loc8 = org.utils.SimpleDateFormatter.getDateFromFormat(date1, dateformat1, language1);
        var _loc9 = org.utils.SimpleDateFormatter.getDateFromFormat(date2, dateformat2, language2);
        if (_loc8 == 0 || _loc9 == 0)
        {
            return (-1);
        }
        else if (_loc8 > _loc9)
        {
            return (1);
        } // end else if
        return (0);
    };
    (_global.org.utils.SimpleDateFormatter = function ()
    {
    }).getDateFromFormat = function (val, format, language)
    {
        if (language == undefined)
        {
            language = "en";
        } // end if
        val = val + "";
        format = format + "";
        var _loc5 = 0;
        var _loc6 = 0;
        var _loc7 = "";
        var _loc8 = "";
        var _loc9 = "";
        var _loc12 = new Date();
        var _loc13 = _loc12.getYear();
        var _loc14 = _loc12.getMonth() + 1;
        var _loc15 = 1;
        var _loc16 = _loc12.getHours();
        var _loc17 = _loc12.getMinutes();
        var _loc18 = _loc12.getSeconds();
        var _loc19 = _loc12.getMilliseconds();
        var _loc20 = "";
        while (_loc6 < format.length)
        {
            _loc7 = format.charAt(_loc6);
            for (var _loc8 = ""; format.charAt(_loc6) == _loc7 && _loc6 < format.length; _loc8 = _loc8 + format.charAt(_loc6++))
            {
            } // end of for
            if (_loc8 == "yyyy" || (_loc8 == "yy" || _loc8 == "y"))
            {
                if (_loc8 == "yyyy")
                {
                    var _loc10 = 4;
                    var _loc11 = 4;
                } // end if
                if (_loc8 == "yy")
                {
                    _loc10 = 2;
                    _loc11 = 2;
                } // end if
                if (_loc8 == "y")
                {
                    _loc10 = 2;
                    _loc11 = 4;
                } // end if
                _loc13 = org.utils.SimpleDateFormatter._getInt(val, _loc5, _loc10, _loc11);
                if (_loc13 == null)
                {
                    return (null);
                } // end if
                _loc5 = _loc5 + _loc13.length;
                if (_loc13.length == 2)
                {
                    if (_loc13 > 70)
                    {
                        _loc13 = 1900 + (_loc13 - 0);
                    }
                    else
                    {
                        _loc13 = 2000 + (_loc13 - 0);
                    } // end if
                } // end else if
                continue;
            } // end if
            if (_loc8 == "MMM" || _loc8 == "NNN")
            {
                _loc14 = 0;
                var _loc21 = 0;
                
                while (++_loc21, _loc21 < org.utils.SimpleDateFormatter.MONTH_NAMES[language].length)
                {
                    var _loc22 = org.utils.SimpleDateFormatter.MONTH_NAMES[language][_loc21];
                    if (val.substring(_loc5, _loc5 + _loc22.length).toLowerCase() == _loc22.toLowerCase())
                    {
                        if (_loc8 == "MMM" || _loc8 == "NNN" && _loc21 > 11)
                        {
                            _loc14 = _loc21 + 1;
                            if (_loc14 > 12)
                            {
                                _loc14 = _loc14 - 12;
                            } // end if
                            _loc5 = _loc5 + _loc22.length;
                            break;
                        } // end if
                    } // end if
                } // end while
                if (_loc14 < 1 || _loc14 > 12)
                {
                    return (null);
                } // end if
                continue;
            } // end if
            if (_loc8 == "EE" || _loc8 == "E")
            {
                var _loc23 = 0;
                
                while (++_loc23, _loc23 < org.utils.SimpleDateFormatter.DAY_NAMES[language].length)
                {
                    var _loc24 = org.utils.SimpleDateFormatter.DAY_NAMES[language][_loc23];
                    if (val.substring(_loc5, _loc5 + _loc24.length).toLowerCase() == _loc24.toLowerCase())
                    {
                        _loc5 = _loc5 + _loc24.length;
                        break;
                    } // end if
                } // end while
                continue;
            } // end if
            if (_loc8 == "MM" || _loc8 == "M")
            {
                _loc14 = org.utils.SimpleDateFormatter._getInt(val, _loc5, _loc8.length, 2);
                if (_loc14 == null || (_loc14 < 1 || _loc14 > 12))
                {
                    return (null);
                } // end if
                _loc5 = _loc5 + _loc14.length;
                continue;
            } // end if
            if (_loc8 == "dd" || _loc8 == "d")
            {
                _loc15 = org.utils.SimpleDateFormatter._getInt(val, _loc5, _loc8.length, 2);
                if (_loc15 == null || (_loc15 < 1 || _loc15 > 31))
                {
                    return (null);
                } // end if
                _loc5 = _loc5 + _loc15.length;
                continue;
            } // end if
            if (_loc8 == "hh" || _loc8 == "h")
            {
                _loc16 = org.utils.SimpleDateFormatter._getInt(val, _loc5, _loc8.length, 2);
                if (_loc16 == null || (_loc16 < 1 || _loc16 > 12))
                {
                    return (null);
                } // end if
                _loc5 = _loc5 + _loc16.length;
                continue;
            } // end if
            if (_loc8 == "HH" || _loc8 == "H")
            {
                _loc16 = org.utils.SimpleDateFormatter._getInt(val, _loc5, _loc8.length, 2);
                if (_loc16 == null || (_loc16 < 0 || _loc16 > 23))
                {
                    return (null);
                } // end if
                _loc5 = _loc5 + _loc16.length;
                continue;
            } // end if
            if (_loc8 == "KK" || _loc8 == "K")
            {
                _loc16 = org.utils.SimpleDateFormatter._getInt(val, _loc5, _loc8.length, 2);
                if (_loc16 == null || (_loc16 < 0 || _loc16 > 11))
                {
                    return (null);
                } // end if
                _loc5 = _loc5 + _loc16.length;
                continue;
            } // end if
            if (_loc8 == "kk" || _loc8 == "k")
            {
                _loc16 = org.utils.SimpleDateFormatter._getInt(val, _loc5, _loc8.length, 2);
                if (_loc16 == null || (_loc16 < 1 || _loc16 > 24))
                {
                    return (null);
                } // end if
                _loc5 = _loc5 + _loc16.length;
                --_loc16;
                continue;
            } // end if
            if (_loc8 == "mm" || _loc8 == "m")
            {
                _loc17 = org.utils.SimpleDateFormatter._getInt(val, _loc5, _loc8.length, 2);
                if (_loc17 == null || (_loc17 < 0 || _loc17 > 59))
                {
                    return (null);
                } // end if
                _loc5 = _loc5 + _loc17.length;
                continue;
            } // end if
            if (_loc8 == "ss" || _loc8 == "s")
            {
                _loc18 = org.utils.SimpleDateFormatter._getInt(val, _loc5, _loc8.length, 2);
                if (_loc18 == null || (_loc18 < 0 || _loc18 > 59))
                {
                    return (null);
                } // end if
                _loc5 = _loc5 + _loc18.length;
                continue;
            } // end if
            if (_loc8 == "ii" || _loc8 == "i")
            {
                _loc19 = org.utils.SimpleDateFormatter._getInt(val, _loc5, _loc8.length, 2);
                if (_loc19 == null || (_loc19 < 0 || _loc19 > 999))
                {
                    return (null);
                } // end if
                _loc5 = _loc5 + _loc19.length;
                continue;
            } // end if
            if (_loc8 == "a")
            {
                if (val.substring(_loc5, _loc5 + 2).toLowerCase() == "am")
                {
                    _loc20 = "AM";
                }
                else if (val.substring(_loc5, _loc5 + 2).toLowerCase() == "pm")
                {
                    _loc20 = "PM";
                }
                else
                {
                    return (null);
                } // end else if
                _loc5 = _loc5 + 2;
                continue;
            } // end if
            if (val.substring(_loc5, _loc5 + _loc8.length) != _loc8)
            {
                return (null);
                continue;
            } // end if
            _loc5 = _loc5 + _loc8.length;
        } // end while
        if (_loc5 != val.length)
        {
            return (null);
        } // end if
        if (_loc14 == 2)
        {
            if (_loc13 % 4 == 0 && _loc13 % 100 != 0 || _loc13 % 400 == 0)
            {
                if (_loc15 > 29)
                {
                    return (null);
                } // end if
            }
            else if (_loc15 > 28)
            {
                return (null);
            } // end if
        } // end else if
        if (_loc14 == 4 || (_loc14 == 6 || (_loc14 == 9 || _loc14 == 11)))
        {
            if (_loc15 > 30)
            {
                return (null);
            } // end if
        } // end if
        if (_loc16 < 12 && _loc20 == "PM")
        {
            _loc16 = _loc16 - 0 + 12;
        }
        else if (_loc16 > 11 && _loc20 == "AM")
        {
            _loc16 = _loc16 - 12;
        } // end else if
        var _loc25 = new Date(_loc13, _loc14 - 1, _loc15, _loc16, _loc17, _loc18, _loc19);
        return (_loc25);
    };
    (_global.org.utils.SimpleDateFormatter = function ()
    {
    })._isInteger = function (val)
    {
        var _loc3 = "1234567890";
        var _loc4 = 0;
        
        while (++_loc4, _loc4 < val.length)
        {
            if (_loc3.indexOf(val.charAt(_loc4)) == -1)
            {
                return (false);
            } // end if
        } // end while
        return (true);
    };
    (_global.org.utils.SimpleDateFormatter = function ()
    {
    })._getInt = function (str, i, minlength, maxlength)
    {
        var _loc6 = maxlength;
        
        while (--_loc6, _loc6 >= minlength)
        {
            var _loc7 = str.substring(i, i + _loc6);
            if (_loc7.length < minlength)
            {
                return (null);
            } // end if
            if (org.utils.SimpleDateFormatter._isInteger(_loc7))
            {
                return (_loc7);
            } // end if
        } // end while
        return (null);
    };
    ASSetPropFlags(_loc1, null, 1);
    (_global.org.utils.SimpleDateFormatter = function ()
    {
    }).MONTH_NAMES_EN = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", _global.org.utils.SimpleDateFormatter = function ()
    {
    }).MONTH_NAMES_FR = new Array("Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre", "Jan", "Fev", "Mar", "Avr", "Mai", "Jun", "Jui", "Aou", "Sep", "Oct", "Nov", "Dec", _global.org.utils.SimpleDateFormatter = function ()
    {
    }).MONTH_NAMES_DE = new Array("Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember", "Jan", "Feb", "Mär", "Apr", "Mai", "Jun", "Jul", "Aug", "Sep", "Okt", "Nov", "Dez", _global.org.utils.SimpleDateFormatter = function ()
    {
    }).MONTH_NAMES_ES = new Array("Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre", "Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic", _global.org.utils.SimpleDateFormatter = function ()
    {
    }).MONTH_NAMES_PT = new Array("Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro", "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez", _global.org.utils.SimpleDateFormatter = function ()
    {
    }).MONTH_NAMES_NL = new Array("Januari", "Februari", "Maart", "April", "Mei", "Juni", "Juli", "Augustus", "September", "Oktober", "November", "December", "Jan", "Feb", "Mrt", "April", "Mei", "Juni", "Juli", "Aug", "Sept", "Okt", "Nov", "Dec", _global.org.utils.SimpleDateFormatter = function ()
    {
    }).MONTH_NAMES_IT = new Array("Gennaio", "Febbraio", "Marzo", "Aprile", "Maggio", "Giugno", "Luglio", "Agosto", "Settembre", "Ottobre", "Novembre", "Dicembre", "Gen", "Feb ", "Mar", "Apr", "Mag", "Giu ", "Lug", "Ago", "Sett", "Ott", "Nov", "Dic");
    (_global.org.utils.SimpleDateFormatter = function ()
    {
    }).MONTH_NAMES = {en: org.utils.SimpleDateFormatter.MONTH_NAMES_EN, fr: org.utils.SimpleDateFormatter.MONTH_NAMES_FR, de: org.utils.SimpleDateFormatter.MONTH_NAMES_DE, es: org.utils.SimpleDateFormatter.MONTH_NAMES_ES, pt: org.utils.SimpleDateFormatter.MONTH_NAMES_PT, nl: org.utils.SimpleDateFormatter.MONTH_NAMES_NL, it: org.utils.SimpleDateFormatter.MONTH_NAMES_IT};
    (_global.org.utils.SimpleDateFormatter = function ()
    {
    }).DAY_NAMES_EN = new Array("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", _global.org.utils.SimpleDateFormatter = function ()
    {
    }).DAY_NAMES_FR = new Array("Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dim", "Lun", "Mar", "Mer", "Jeu", "Ven", "Sam", _global.org.utils.SimpleDateFormatter = function ()
    {
    }).DAY_NAMES_DE = new Array("Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "So", "Mo", "Di", "Mi", "Do", "Fr", "Sa", _global.org.utils.SimpleDateFormatter = function ()
    {
    }).DAY_NAMES_ES = new Array("Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Dom", "Lun", "Mar", "Mié ", "Jue", "Vie", "Sáb", _global.org.utils.SimpleDateFormatter = function ()
    {
    }).DAY_NAMES_PT = new Array("Domingo", "Terça-feira", "Quarta-feira", "Quinta-feira", "Sexta-feira", "Sábado", "Segunda-feira", "Dom", "Ter", "Qua", "Qui", "Sex", "Sáb", "Seg", _global.org.utils.SimpleDateFormatter = function ()
    {
    }).DAY_NAMES_NL = new Array("Zondag", "Maandag", "Dinsdag", "Woensdag", "Donderdag", "Vrijdag", "Zaterdag", "Zo", "Ma", "Di", "Wo", "Do", "Vrij", "Za", _global.org.utils.SimpleDateFormatter = function ()
    {
    }).DAY_NAMES_IT = new Array("Domenica", "Lunedi", "Martedì ", "Mercoledì ", "Giovedi", "Venerdì ", "Sabato", "Sole", "Lun", "Mar", "Mer", "Gio", "Ven", "Sab");
    (_global.org.utils.SimpleDateFormatter = function ()
    {
    }).DAY_NAMES = {en: org.utils.SimpleDateFormatter.DAY_NAMES_EN, fr: org.utils.SimpleDateFormatter.DAY_NAMES_FR, de: org.utils.SimpleDateFormatter.DAY_NAMES_DE, es: org.utils.SimpleDateFormatter.DAY_NAMES_ES, pt: org.utils.SimpleDateFormatter.DAY_NAMES_PT, nl: org.utils.SimpleDateFormatter.DAY_NAMES_NL, it: org.utils.SimpleDateFormatter.DAY_NAMES_IT};
} // end if
#endinitclip
