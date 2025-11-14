cmake_minimum_required(VERSION 3.23)


function(FilterFoo OutVar)
# TODO3: Search all the variables in the argument list passed to FilterFoo,
#        and place those containing "Foo" into the list named by "OutVar"
  foreach(item IN LISTS ARGN)
    if(item MATCHES "[Ff][Oo][Oo]")
      list(APPEND ${OutVar} ${item})
    endif()
    endforeach()
  set(${OutVar} ${${OutVar}} PARENT_SCOPE)
endfunction()

#if(True)
#  message("Constant Value: True")
#else()
#  message("Constant Value: False")
#endif()

#if(ConditionalValue)
#  message("Undefined Variable: True")
#else()
#  message("Undefined Variable: False")
#endif()

#set(ConditionalValue True)

#if(ConditionalValue)
#  message("Defined Variable: True")
#else()
#  message("Defined Variable: False")
#endif()

# Testing for the above
function(check_contains var)
  if(NOT var IN_LIST OutList)
    message(WARNING "OutList does not contain: ${var}")
    set(Failed True PARENT_SCOPE)
  endif()
endfunction()

function(check_nonfoo)
  list(FILTER ARGN EXCLUDE REGEX Foo)
  if(NOT ARGN STREQUAL "")
    message(WARNING "OutList contains extra item(s): ${ARGN}")
    set(Failed True PARENT_SCOPE)
  endif()
endfunction()

if(SKIP_TESTS)
  return()
endif()

set(InList FooBar BarBaz FooBaz BazBar QuxFoo BazQux)

FilterFoo(OutList ${InList})

if(NOT DEFINED OutList)
  message("FilterFoo unimplemented or does nothing")
  return()
endif()

set(Failed False)

check_contains(FooBar)
check_contains(FooBaz)
check_contains(QuxFoo)
check_nonfoo(${OutList})

if(NOT Failed)
  message("Success!")
endif()
