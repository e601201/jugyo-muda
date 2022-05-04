window.testIt = (person,day) => {
  const saveCheckbox = document.getElementById(`js_${person}_shift_${day}`)
  const begin_at = document.getElementById(`js_${person}_begin_at_${day}`);
  const end_at = document.getElementById(`js_${person}_end_at_${day}`);
  if (saveCheckbox.checked){
    begin_at.disabled = true;
    end_at.disabled = true;
  }else{
    begin_at.disabled = false;
    end_at.disabled = false;
  }
}