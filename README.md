# moore-fsm

comprehensive approach for a simple study task

the greatest things were made for rofl, including this one

# includes

- task as transitions table
- python script to make a transitions list
- transitions list
- rtl for 16-state Moore fsm
- tb covering all possible states and transitions
  - ..and checking it using the trans. list
- pkg with transitions array used in tb

# how to use

1. make your task look like mine
2. run script and get a transitions list
   - may be used to change rtl for your task
3. use copy-paste to form 'TRANS_ARR` (transitions array) in the pkg
   - replace all `4b` to `4'b`, it was python not me
   - move `TRANS_NUM` declaration up
   - `TRANS_ARR` elem format is `{ current_state , input , new_state }`
4. make a project including tb, rtl and pkg
5. run test, enjoy it
