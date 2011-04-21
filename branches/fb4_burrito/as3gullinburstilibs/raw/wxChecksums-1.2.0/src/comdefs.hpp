/*
 * wxChecksums
 * Copyright (C) 2003-2004 Julien Couot
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

/**
 * \file comdefs.hpp
 * Common definitions for the application.
 */


#ifndef INC_COMDEFS_HPP
#define INC_COMDEFS_HPP


/// Application's major version number
#define  APP_MAJOR_VER  1

/// Application's minor version number
#define  APP_MINOR_VER  2

/// Application's subversion number
#define  APP_SUBVER     0

/// Application's build number
#define  APP_BUILD      9

/// Application's special (like 'alpha', 'beta', 'rc')
#define  APP_SPECIAL    ""

/// Application's name
#define  APP_NAME       "wxChecksums"

/// Application's author/vendor
#define  APP_AUTHOR     "Julien Couot"

/// Application's development years
#define  APP_DEV_DATES  "2003-2004"

/// The space between 2 controls.
#define  CONTROL_SPACE  10

/// Time between two updates of the progress dialogs in milliseconds
#define  UPDATE_PROGRESS_DLG  250


/// Maximal size for the buffer of file reading.
#define  MAX_BUFF_SIZE  1048576

/// Default size for the buffer of file reading.
#define  DEF_BUFF_SIZE  0xFFFF


#endif  // INC_COMDEFS_HPP
