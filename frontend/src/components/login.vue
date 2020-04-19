<template>
  <div style="margin: 5% 30% 15% 30%;">
    <h1>User Login</h1>
    <a-form
      id="components-form-normal-login"
      :form="form"
      class="login-form"
      @submit.prevent="login"
    >
      <a-form-item>
        <a-input
          v-decorator="[
            'username',
            { rules: [{ required: true, message: 'Please input your username!' }] },
          ]"
          placeholder="Username"
        >
          <a-icon slot="prefix" type="user" style="color: rgba(0,0,0,.25)" />
        </a-input>
      </a-form-item>
      <a-form-item>
        <a-input
          v-decorator="[
            'password',
            { rules: [{ required: true, message: 'Please input your Password!' }] },
          ]"
          type="password"
          placeholder="Password"
        >
          <a-icon slot="prefix" type="lock" style="color: rgba(0,0,0,.25)" />
        </a-input>
      </a-form-item>
      <a-form-item>
        <a-checkbox
          v-decorator="[
            'remember',
            {
              valuePropName: 'checked',
              initialValue: true,
            },
          ]"
          style = "float: left;"
        >
          Remember me
        </a-checkbox>
        <a-button type="primary" html-type="submit" class="login-form-button" style="width: 50%; float: right;">
          Log in
        </a-button>
      </a-form-item>
    </a-form>
    <p style="color: red;">{{ msg }}</p>
  </div>
</template>

<script>
export default {
  data () {
    return {
      msg: ''
    };
  },

  beforeCreate() {
    this.form = this.$form.createForm(this, { name: 'normal_login' });
  },

  methods: {
    login(e) {
      e.preventDefault();
      this.form.validateFields((err, values) => {
        if (!err) {
          const { username, password } = values
          this.$store.dispatch('login', { username, password })
          .then(() => this.$router.push('/'))
          .catch(err => {
            console.log(err)
            this.msg = 'wrong username or password'
          })
        }
      });
    },
  }
};
</script>
