using System;
using System.Data;
using System.Web.UI.WebControls;
using TKFTaskDemo.BLL;

namespace TKFTaskDemo
{
    public partial class EmployeeDetails : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                BindSkills();

            }
            this.BindGrid();

        }

        private void BindSkills()
        {
            DataSet ds = new DataSet();
            ds = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteDataset(ConnectionManager.ConnectionString, "PropGetSkills");
            lstSkills.DataSource = ds;
            lstSkills.DataTextField = "SkillName";
            lstSkills.DataValueField = "SkillID";
            lstSkills.DataBind();

        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            SaveandUpdateData();
        }

        private void SaveandUpdateData()
        {
            if (btnSave.Text == "Save")
            {

                object EmpID = 0;

                EmpID = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteScalar(ConnectionManager.ConnectionString, "PropsSaveEmployeeDetails", txtName.Text, txtDOB.Text, txtDesignation.Text);
                SaveSkills(Convert.ToInt32(EmpID));
            }
            else
            {

                Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteScalar(ConnectionManager.ConnectionString, "PropsUpdateEmployeeDetails", Convert.ToInt32(hdnUpdatedEmpID.Value), txtName.Text, txtDOB.Text, txtDesignation.Text);
                SaveSkills(Convert.ToInt32(hdnUpdatedEmpID.Value));
            }
            
            BindGrid();
            ClearControl();
        }
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearControl();
        }

        private void SaveSkills(int EmpID)
        {
            foreach (ListItem item in lstSkills.Items)
            {
                if (item.Selected)
                {
                    Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteNonQuery(ConnectionManager.ConnectionString, "PropsSaveSkills", EmpID, item.Value);
                }
            }
        }

        protected void BindGrid()
        {
            DataSet ds = new DataSet();
            ds = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteDataset(ConnectionManager.ConnectionString, "PropGetEmployeeDetails");

            dgEmployeeDetails.DataSource = ds;
            dgEmployeeDetails.DataBind();

        }

        private void ClearControl()
        {
            Response.Redirect("/");
        }

        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            dgEmployeeDetails.EditIndex = e.NewEditIndex;
            int EmpID = Convert.ToInt32(dgEmployeeDetails.DataKeys[e.NewEditIndex].Values[0]);
            btnSave.Text = "Update";
            this.BindUserData(EmpID); 
        }

        private void BindUserData(int EmpID)
        {
            DataSet ds = new DataSet();
            ds = Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteDataset(ConnectionManager.ConnectionString, "PropGetUserEdit", EmpID);

            if (ds.Tables[0].Rows.Count > 0)
            {
                hdnUpdatedEmpID.Value = EmpID.ToString();
                txtName.Text = ds.Tables[0].Rows[0].ItemArray[0].ToString();
                txtDOB.Text = ds.Tables[0].Rows[0].ItemArray[1].ToString();
                txtDesignation.Text = ds.Tables[0].Rows[0].ItemArray[2].ToString();

                string[] listData = ds.Tables[0].Rows[0].ItemArray[3].ToString().Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

                string itemselectData = ds.Tables[0].Rows[0].ItemArray[3].ToString().Trim();
                foreach (ListItem item in lstSkills.Items)
                {
                    if (item.Selected == false && itemselectData.Contains(item.Text))
                    {
                        item.Selected = true;
                    }
                }
            }

        }

        protected void OnPaging(object sender, GridViewPageEventArgs e)
        {
            dgEmployeeDetails.PageIndex = e.NewPageIndex;
            this.BindGrid();
        }
      
        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            int Delete_EmpID = Convert.ToInt32(dgEmployeeDetails.DataKeys[e.RowIndex].Values[0]);

            Microsoft.ApplicationBlocks.Data.SqlHelper.ExecuteNonQuery(ConnectionManager.ConnectionString, "PropsDeleteEmpolyeeDetails", Delete_EmpID);

            ClearControl();
            
        }

        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            SaveandUpdateData();
        }
        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            ClearControl();
        }
    }
}